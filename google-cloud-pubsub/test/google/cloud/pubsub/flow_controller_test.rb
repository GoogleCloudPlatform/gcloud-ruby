# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "helper"
require "concurrent/atomics"

describe Google::Cloud::PubSub::FlowController, :mock_pubsub do
  let(:message_size_bytes) { 3 }

  it "knows its default settings" do
    flow_controller = Google::Cloud::PubSub::FlowController.new

    _(flow_controller.message_limit).must_equal 1000 # 10 * AsyncPublisher#max_messages
    _(flow_controller.byte_limit).must_equal 10_000_000 # 10 * AsyncPublisher#max_bytes
    _(flow_controller.limit_exceeded_behavior).must_equal :ignore
  end

  it "knows its custom settings" do
    flow_controller = Google::Cloud::PubSub::FlowController.new(
      message_limit: 123,
      byte_limit: 456,
      limit_exceeded_behavior: :block
    )

    _(flow_controller.message_limit).must_equal 123
    _(flow_controller.byte_limit).must_equal 456
    _(flow_controller.limit_exceeded_behavior).must_equal :block
  end

  describe "ignore" do
    it "does not raise or block when > message_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1,
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :ignore
      )

      flow_controller.acquire message_size_bytes
      flow_controller.acquire message_size_bytes
    end

    it "does not raise or block when > byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: 1,
        limit_exceeded_behavior: :ignore
      )

      flow_controller.acquire message_size_bytes
      flow_controller.acquire message_size_bytes
    end
  end

  describe "error" do
    it "does not raise when <= message_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 2,
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes
      flow_controller.acquire message_size_bytes
    end

    it "does not raise when <= byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: message_size_bytes * 2,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes
      flow_controller.acquire message_size_bytes
    end

    it "raises when > message_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1,
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes
      flow_controller.release message_size_bytes
      flow_controller.acquire message_size_bytes
      expect do
        flow_controller.acquire message_size_bytes
      end.must_raise Google::Cloud::PubSub::FlowControlLimitError
    end

    it "raises when > byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: message_size_bytes,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes
      flow_controller.release message_size_bytes
      flow_controller.acquire message_size_bytes
      expect do
        flow_controller.acquire message_size_bytes
      end.must_raise Google::Cloud::PubSub::FlowControlLimitError
    end

    it "does not raise when sufficient capacity is released before new acquires" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 2,
        byte_limit: message_size_bytes * 2,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes
      flow_controller.acquire message_size_bytes
      flow_controller.release message_size_bytes
      flow_controller.acquire message_size_bytes
      flow_controller.release message_size_bytes
      flow_controller.acquire message_size_bytes
    end

    it "works correctly even after too many message limit releases" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1,
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes

      flow_controller.release message_size_bytes
      flow_controller.release message_size_bytes # Bad release!

      flow_controller.acquire message_size_bytes
      expect do
        flow_controller.acquire message_size_bytes
      end.must_raise Google::Cloud::PubSub::FlowControlLimitError
      flow_controller.release message_size_bytes
      flow_controller.acquire message_size_bytes
    end

    it "works correctly even after too many byte limit releases" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: message_size_bytes,
        limit_exceeded_behavior: :error
      )

      flow_controller.acquire message_size_bytes

      flow_controller.release message_size_bytes
      flow_controller.release message_size_bytes # Bad release!

      flow_controller.acquire message_size_bytes
      expect do
        flow_controller.acquire message_size_bytes
      end.must_raise Google::Cloud::PubSub::FlowControlLimitError
      flow_controller.release message_size_bytes
      flow_controller.acquire message_size_bytes
    end
  end

  describe "block" do
    it "does not block when <= message_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 3,
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :block
      )

      adding_1_done = Concurrent::Event.new
      adding_2_done = Concurrent::Event.new
      adding_3_done = Concurrent::Event.new
      releasing_1_done = Concurrent::Event.new
      releasing_2_done = Concurrent::Event.new
      releasing_3_done = Concurrent::Event.new

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_1_done
      assert adding_1_done.wait(0.1), "Adding message 1 never unblocked."
      run_in_thread flow_controller, :acquire, message_size_bytes, adding_2_done
      assert adding_2_done.wait(0.1), "Adding message 2 never unblocked."
      run_in_thread flow_controller, :acquire, message_size_bytes, adding_3_done
      assert adding_3_done.wait(0.1), "Adding message 3 never unblocked."
      run_in_thread flow_controller, :release, message_size_bytes, releasing_1_done
      assert releasing_1_done.wait(0.1), "Releasing message 1 never unblocked."
      run_in_thread flow_controller, :release, message_size_bytes, releasing_2_done
      assert releasing_2_done.wait(0.1), "Releasing message 2 never unblocked."
      run_in_thread flow_controller, :release, message_size_bytes, releasing_3_done
      assert releasing_3_done.wait(0.1), "Releasing message 3 never unblocked."
    end

    it "does not block when <= byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: message_size_bytes * 3,
        limit_exceeded_behavior: :block
      )

      adding_1_done = Concurrent::Event.new
      adding_2_done = Concurrent::Event.new
      adding_3_done = Concurrent::Event.new
      releasing_1_done = Concurrent::Event.new
      releasing_2_done = Concurrent::Event.new
      releasing_3_done = Concurrent::Event.new

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_1_done
      assert adding_1_done.wait(0.1), "Adding message 1 never unblocked."
      run_in_thread flow_controller, :acquire, message_size_bytes, adding_2_done
      assert adding_2_done.wait(0.1), "Adding message 2 never unblocked."
      run_in_thread flow_controller, :acquire, message_size_bytes, adding_3_done
      assert adding_3_done.wait(0.1), "Adding message 3 never unblocked."
      run_in_thread flow_controller, :release, message_size_bytes, releasing_1_done
      assert releasing_1_done.wait(0.1), "Releasing message 1 never unblocked."
      run_in_thread flow_controller, :release, message_size_bytes, releasing_2_done
      assert releasing_2_done.wait(0.1), "Releasing message 2 never unblocked."
      run_in_thread flow_controller, :release, message_size_bytes, releasing_3_done
      assert releasing_3_done.wait(0.1), "Releasing message 3 never unblocked."
    end

    it "raises when a single message is > message_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 0, # Non-sane setting
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :block
      )

      expect do
        flow_controller.acquire message_size_bytes
      end.must_raise Google::Cloud::PubSub::FlowControlLimitError
    end

    it "raises when a single message is > byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: message_size_bytes,
        limit_exceeded_behavior: :block
      )

      expect do
        flow_controller.acquire message_size_bytes * 2
      end.must_raise Google::Cloud::PubSub::FlowControlLimitError
    end

    it "blocks when > message_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1,
        byte_limit: 10_000_000,
        limit_exceeded_behavior: :block
      )

      adding_1_done = Concurrent::Event.new
      adding_2_done = Concurrent::Event.new
      adding_3_done = Concurrent::Event.new
      releasing_1_done = Concurrent::Event.new
      releasing_2_done = Concurrent::Event.new

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_1_done
      assert adding_1_done.wait(0.1), "Adding message 1 never unblocked."

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_2_done
      refute adding_2_done.wait(0.1), "Adding message 2 did not block."

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_3_done
      refute adding_3_done.wait(0.1), "Adding message 3 did not block."

      run_in_thread flow_controller, :release, message_size_bytes, releasing_1_done
      assert releasing_1_done.wait(0.1), "Releasing message 1 errored."

      assert adding_2_done.wait(0.1), "Adding message 2 never unblocked."

      run_in_thread flow_controller, :release, message_size_bytes, releasing_2_done
      assert releasing_2_done.wait(0.1), "Releasing message 2 errored."

      assert adding_3_done.wait(0.1), "Adding message 3 never unblocked."
    end

    it "blocks when > byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: message_size_bytes,
        limit_exceeded_behavior: :block
      )

      adding_1_done = Concurrent::Event.new
      adding_2_done = Concurrent::Event.new
      adding_3_done = Concurrent::Event.new
      releasing_1_done = Concurrent::Event.new
      releasing_2_done = Concurrent::Event.new

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_1_done
      assert adding_1_done.wait(0.1), "Adding message 1 never unblocked."

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_2_done
      refute adding_2_done.wait(0.1), "Adding message 2 did not block."

      run_in_thread flow_controller, :acquire, message_size_bytes, adding_3_done
      refute adding_3_done.wait(0.1), "Adding message 3 did not block."

      run_in_thread flow_controller, :release, message_size_bytes, releasing_1_done
      assert releasing_1_done.wait(0.1), "Releasing message 1 errored."

      assert adding_2_done.wait(0.1), "Adding message 2 never unblocked."

      run_in_thread flow_controller, :release, message_size_bytes, releasing_2_done
      assert releasing_2_done.wait(0.1), "Releasing message 2 errored."

      assert adding_3_done.wait(0.1), "Adding message 3 never unblocked."
    end

    it "blocks but does not starve large messages when > byte_limit" do
      flow_controller = Google::Cloud::PubSub::FlowController.new(
        message_limit: 1000,
        byte_limit: 110,
        limit_exceeded_behavior: :block
      )

      large_msg = 100 # close to entire byte limit

      adding_initial_done = Concurrent::Event.new
      adding_large_done = Concurrent::Event.new
      adding_busy_done = Concurrent::Event.new
      releasing_busy_done = Concurrent::Event.new
      releasing_large_done = Concurrent::Event.new

      # Occupy some of the flow capacity, then try to add a large message. Releasing
      # enough messages should eventually allow the large message to come through, even
      # if more messages are added after it (those should wait for the large message).
      initial_messages = Array.new(5) { 10 }
      run_in_thread flow_controller, :acquire, initial_messages, adding_initial_done
      assert adding_initial_done.wait(0.1), "Adding initial messages blocked or errored."

      run_in_thread flow_controller, :acquire, large_msg, adding_large_done

      # Continuously keep adding more messages after the large one.
      messages = Array.new(10) { 10 }
      run_in_thread flow_controller, :acquire, messages, adding_busy_done, action_pause: 0.1

      # At the same time, gradually keep releasing the messages - the released
      # capacity should be consumed by the large message, not the other small messages
      # being added after it.
      run_in_thread flow_controller, :release, messages, releasing_busy_done, action_pause: 0.1

      # Sanity check - releasing should have completed by now.
      assert releasing_busy_done.wait(2), "Releasing messages blocked or errored."

      # Enough messages released, the large message should have come through in the meantime.
      assert adding_large_done.wait(1), "A thread adding a large message starved."

      refute adding_busy_done.wait(0.1), "Adding multiple small messages did not block."

      # Releasing the large message should unblock adding the remaining "busy" messages
      # that have not been added yet.
      run_in_thread flow_controller, :release, large_msg, releasing_large_done
      assert releasing_large_done.wait(0.1), "Releasing a message blocked or errored."

      assert adding_busy_done.wait(1.0), "Adding messages blocked or errored."
    end
  end

  def pubsub_message data
    Google::Cloud::PubSub::V1::PubsubMessage.new data: data
  end

  # Run flow controller action in a separate thread.
  def run_in_thread flow_controller,
                    action,
                    messages,
                    all_done_event,
                    error_event: nil,
                    action_pause: nil

    assert [:acquire, :release].include? action

    Thread.new do
      begin
        Array(messages).each do |msg|
          sleep action_pause if action_pause
          flow_controller.send action, msg
        end
        all_done_event.set
      rescue FlowControlLimitError => e
        error_event.set if error_event
      end
    end
  end
end
