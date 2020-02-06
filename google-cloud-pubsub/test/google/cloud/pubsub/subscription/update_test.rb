# Copyright 2017 Google LLC
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

describe Google::Cloud::PubSub::Subscription, :update, :mock_pubsub do
  let(:topic_name) { "topic-name-goes-here" }
  let(:sub_name) { "subscription-name-goes-here" }
  let(:sub_path) { subscription_path sub_name }
  let(:labels) { { "foo" => "bar" } }
  let(:new_labels) { { "baz" => "qux" } }
  let(:new_labels_map) do
    labels_map = Google::Protobuf::Map.new(:string, :string)
    new_labels.each { |k, v| labels_map[String(k)] = String(v) }
    labels_map
  end
  let(:dead_letter_topic_name) { "topic-name-dead-letter" }
  let(:dead_letter_topic_path) { topic_path(dead_letter_topic_name) }
  let(:new_dead_letter_topic_name) { "topic-name-dead-letter-2" }
  let(:new_dead_letter_topic) { Google::Cloud::PubSub::Topic.from_grpc Google::Cloud::PubSub::V1::Topic.new(topic_hash(new_dead_letter_topic_name)), pubsub.service }
  let(:sub_hash) { subscription_hash topic_name, sub_name, labels: labels, dead_letter_topic: dead_letter_topic_path, max_delivery_attempts: 6 }
  let(:sub_deadline) { sub_hash["ack_deadline_seconds"] }
  let(:sub_endpoint) { sub_hash["push_config"]["push_endpoint"] }
  let(:sub_grpc) { Google::Cloud::PubSub::V1::Subscription.new(sub_hash) }
  let(:subscription) { Google::Cloud::PubSub::Subscription.from_grpc sub_grpc, pubsub.service }

  it "updates deadline" do
    subscription.deadline.must_equal 60

    update_sub = update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, ack_deadline_seconds: 30
    update_mask = Google::Protobuf::FieldMask.new paths: ["ack_deadline_seconds"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.deadline = 30

    mock.verify

    subscription.deadline.must_equal 30
  end

  it "updates retain_acked" do
    subscription.retain_acked.must_equal true

    update_sub = update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, retain_acked_messages: false
    update_mask = Google::Protobuf::FieldMask.new paths: ["retain_acked_messages"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.retain_acked = false

    mock.verify

    subscription.retain_acked.must_equal false
  end

  it "updates retention" do
    subscription.retention.must_equal 600.9

    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, message_retention_duration: Google::Cloud::PubSub::Convert.number_to_duration(600.2)
    update_mask = Google::Protobuf::FieldMask.new paths: ["message_retention_duration"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.retention = 600.2

    mock.verify

    subscription.retention.must_equal 600.2
  end

  it "updates labels" do
    subscription.labels.must_equal labels

    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, labels: new_labels
    update_mask = Google::Protobuf::FieldMask.new paths: ["labels"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.labels = new_labels

    mock.verify

    subscription.labels.must_equal new_labels
  end

  it "updates labels to empty hash" do
    subscription.labels.must_equal labels

    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, labels: {}

    update_mask = Google::Protobuf::FieldMask.new paths: ["labels"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.labels = {}

    mock.verify

    subscription.labels.wont_be :nil?
    subscription.labels.must_be :empty?
  end

  it "raises when setting labels to nil" do
    subscription.labels.must_equal labels

    expect { subscription.labels = nil }.must_raise ArgumentError

    subscription.labels.must_equal labels
  end

  it "can update the endpoint" do
    new_push_endpoint = "https://foo.bar/baz"

    push_config = Google::Cloud::PubSub::V1::PushConfig.new(push_endpoint: new_push_endpoint)
    mpc_res = nil
    mock = Minitest::Mock.new
    mock.expect :modify_push_config, mpc_res, [subscription_path(sub_name), push_config, options: default_options]
    pubsub.service.mocked_subscriber = mock

    subscription.endpoint = new_push_endpoint

    mock.verify
  end

  it "can update the expires_in" do
    week_seconds = 60*60*24*7

    expiration_policy = Google::Cloud::PubSub::V1::ExpirationPolicy.new(
      ttl: Google::Cloud::PubSub::Convert.number_to_duration(week_seconds)
    )
    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, expiration_policy: expiration_policy
    update_mask = Google::Protobuf::FieldMask.new paths: ["expiration_policy"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    pubsub.service.mocked_subscriber = mock

    subscription.expires_in = week_seconds

    mock.verify

    subscription.expires_in.must_equal week_seconds
  end

  it "can update the expires_in to nil" do
    expiration_policy = Google::Cloud::PubSub::V1::ExpirationPolicy.new
    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, expiration_policy: expiration_policy
    update_mask = Google::Protobuf::FieldMask.new paths: ["expiration_policy"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    pubsub.service.mocked_subscriber = mock

    subscription.expires_in = nil

    mock.verify

    subscription.expires_in.must_be :nil?
  end

  it "updates push_config" do
    subscription.push_config.must_be_kind_of Google::Cloud::PubSub::Subscription::PushConfig
    subscription.push_config.endpoint.must_equal "http://example.com/callback"
    subscription.push_config.authentication.must_be_kind_of Google::Cloud::PubSub::Subscription::PushConfig::OidcToken
    subscription.push_config.authentication.email.must_equal "user@example.com"
    subscription.push_config.authentication.audience.must_equal "client-12345"

    update_sub = Google::Cloud::PubSub::V1::Subscription.new(
      name: sub_path, push_config: Google::Cloud::PubSub::V1::PushConfig.new(
        push_endpoint: "http://example.net/endpoint",
        oidc_token: Google::Cloud::PubSub::V1::PushConfig::OidcToken.new(
          service_account_email: "admin@example.net",
          audience: "some-header-value"
        )
      )
    )
    update_mask = Google::Protobuf::FieldMask.new paths: ["push_config"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.push_config do |pc|
      pc.endpoint = "http://example.net/endpoint"
      pc.set_oidc_token "admin@example.net", "some-header-value"
    end

    mock.verify

    subscription.push_config.must_be_kind_of Google::Cloud::PubSub::Subscription::PushConfig
    subscription.push_config.endpoint.must_equal "http://example.net/endpoint"
    subscription.push_config.authentication.must_be_kind_of Google::Cloud::PubSub::Subscription::PushConfig::OidcToken
    subscription.push_config.authentication.email.must_equal "admin@example.net"
    subscription.push_config.authentication.audience.must_equal "some-header-value"
  end

  it "updates dead_letter_topic" do
    dead_letter_policy = Google::Cloud::PubSub::V1::DeadLetterPolicy.new(dead_letter_topic: new_dead_letter_topic.name, max_delivery_attempts: 6)
    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, dead_letter_policy: dead_letter_policy
    update_mask = Google::Protobuf::FieldMask.new paths: ["dead_letter_policy"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.dead_letter_topic = new_dead_letter_topic

    mock.verify

    subscription.dead_letter_topic.name.must_equal new_dead_letter_topic.name
    subscription.dead_letter_max_delivery_attempts.must_equal 6
  end

  it "updates dead_letter_max_delivery_attempts" do
    dead_letter_policy = Google::Cloud::PubSub::V1::DeadLetterPolicy.new(dead_letter_topic: dead_letter_topic_path, max_delivery_attempts: 7)
    update_sub = Google::Cloud::PubSub::V1::Subscription.new \
      name: sub_path, dead_letter_policy: dead_letter_policy
    update_mask = Google::Protobuf::FieldMask.new paths: ["dead_letter_policy"]
    mock = Minitest::Mock.new
    mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
    subscription.service.mocked_subscriber = mock

    subscription.dead_letter_max_delivery_attempts = 7

    mock.verify

    subscription.dead_letter_topic.name.must_equal dead_letter_topic_path
    subscription.dead_letter_max_delivery_attempts.must_equal 7
  end

  it "raises when updating dead_letter_max_delivery_attempts if dead_letter_topic is not set" do
    grpc = Google::Cloud::PubSub::V1::Subscription.new(subscription_hash(topic_name, sub_name))
    subscription_without_dead_letter = Google::Cloud::PubSub::Subscription.from_grpc grpc, pubsub.service
    assert_raises ArgumentError do
      subscription_without_dead_letter.dead_letter_max_delivery_attempts = 7
    end
  end

  describe :reference do
    let(:subscription) { Google::Cloud::PubSub::Subscription.from_name sub_name, pubsub.service }

    it "updates deadline" do
      subscription.must_be :reference?
      subscription.wont_be :resource?

      update_sub = Google::Cloud::PubSub::V1::Subscription.new \
        name: subscription_path(sub_name),
        ack_deadline_seconds: 30
      sub_grpc.ack_deadline_seconds = 30
      update_mask = Google::Protobuf::FieldMask.new paths: ["ack_deadline_seconds"]
      mock = Minitest::Mock.new
      mock.expect :update_subscription, sub_grpc, [update_sub, update_mask, options: default_options]
      subscription.service.mocked_subscriber = mock

      subscription.deadline = 30

      mock.verify

      subscription.wont_be :reference?
      subscription.must_be :resource?
      subscription.deadline.must_equal 30
    end

    it "updates retain_acked" do
      subscription.must_be :reference?
      subscription.wont_be :resource?

      update_sub = Google::Cloud::PubSub::V1::Subscription.new \
        name: subscription_path(sub_name),
        retain_acked_messages: true
      sub_grpc.retain_acked_messages = true
      update_mask = Google::Protobuf::FieldMask.new paths: ["retain_acked_messages"]
      mock = Minitest::Mock.new
      mock.expect :update_subscription, sub_grpc, [update_sub, update_mask, options: default_options]
      subscription.service.mocked_subscriber = mock

      subscription.retain_acked = true

      mock.verify

      subscription.wont_be :reference?
      subscription.must_be :resource?
      subscription.retain_acked.must_equal true
    end

    it "updates retention" do
      subscription.must_be :reference?
      subscription.wont_be :resource?

      update_sub = Google::Cloud::PubSub::V1::Subscription.new \
        name: subscription_path(sub_name),
        message_retention_duration: Google::Cloud::PubSub::Convert.number_to_duration(600.2)
      sub_grpc.message_retention_duration = Google::Cloud::PubSub::Convert.number_to_duration 600.2
      update_mask = Google::Protobuf::FieldMask.new paths: ["message_retention_duration"]
      mock = Minitest::Mock.new
      mock.expect :update_subscription, sub_grpc, [update_sub, update_mask, options: default_options]
      subscription.service.mocked_subscriber = mock

      subscription.retention = 600.2

      mock.verify

      subscription.wont_be :reference?
      subscription.must_be :resource?
      subscription.retention.must_equal 600.2
    end

    it "updates labels" do
      subscription.must_be :reference?
      subscription.wont_be :resource?

      update_sub = Google::Cloud::PubSub::V1::Subscription.new \
        name: subscription_path(sub_name),
        labels: new_labels
      sub_grpc.labels = new_labels_map
      update_mask = Google::Protobuf::FieldMask.new paths: ["labels"]
      mock = Minitest::Mock.new
      mock.expect :update_subscription, sub_grpc, [update_sub, update_mask, options: default_options]
      subscription.service.mocked_subscriber = mock

      subscription.labels = new_labels

      mock.verify

      subscription.wont_be :reference?
      subscription.must_be :resource?
      subscription.labels.must_equal new_labels
    end

    it "makes an HTTP API call to update endpoint" do
      new_push_endpoint = "https://foo.bar/baz"

      push_config = Google::Cloud::PubSub::V1::PushConfig.new(push_endpoint: new_push_endpoint)
      mpc_res = nil
      mock = Minitest::Mock.new
      mock.expect :modify_push_config, mpc_res, [subscription_path(sub_name), push_config, options: default_options]
      pubsub.service.mocked_subscriber = mock

      subscription.endpoint = new_push_endpoint

      mock.verify
    end

    it "makes an HTTP API call to update expires_in" do
      week_seconds = 60*60*24*7

      expiration_policy = Google::Cloud::PubSub::V1::ExpirationPolicy.new(
        ttl: Google::Cloud::PubSub::Convert.number_to_duration(week_seconds)
      )
      update_sub = Google::Cloud::PubSub::V1::Subscription.new \
        name: sub_path, expiration_policy: expiration_policy
      update_mask = Google::Protobuf::FieldMask.new paths: ["expiration_policy"]
      mock = Minitest::Mock.new
      mock.expect :update_subscription, update_sub, [update_sub, update_mask, options: default_options]
      pubsub.service.mocked_subscriber = mock

      subscription.expires_in = week_seconds

      mock.verify
    end
  end

  describe "reference subscription object of a subscription that does not exist" do
    let :subscription do
      Google::Cloud::PubSub::Subscription.from_name sub_name,
                                            pubsub.service
    end

    it "raises NotFoundError when updating deadline" do
      stub = Object.new
      def stub.update_subscription *args
        gax_error = Google::Gax::GaxError.new "not found"
        gax_error.instance_variable_set :@cause, GRPC::BadStatus.new(5, "not found")
        raise gax_error
      end
      subscription.service.mocked_subscriber = stub

      expect do
        subscription.deadline = 30
      end.must_raise Google::Cloud::NotFoundError
    end

    it "raises NotFoundError when updating retain_acked" do
      stub = Object.new
      def stub.update_subscription *args
        gax_error = Google::Gax::GaxError.new "not found"
        gax_error.instance_variable_set :@cause, GRPC::BadStatus.new(5, "not found")
        raise gax_error
      end
      subscription.service.mocked_subscriber = stub

      expect do
        subscription.retain_acked = true
      end.must_raise Google::Cloud::NotFoundError
    end

    it "raises NotFoundError when updating retention" do
      stub = Object.new
      def stub.update_subscription *args
        gax_error = Google::Gax::GaxError.new "not found"
        gax_error.instance_variable_set :@cause, GRPC::BadStatus.new(5, "not found")
        raise gax_error
      end
      subscription.service.mocked_subscriber = stub

      expect do
        subscription.retention = 600.2
      end.must_raise Google::Cloud::NotFoundError
    end

    it "raises NotFoundError when updating labels" do
      stub = Object.new
      def stub.update_subscription *args
        gax_error = Google::Gax::GaxError.new "not found"
        gax_error.instance_variable_set :@cause, GRPC::BadStatus.new(5, "not found")
        raise gax_error
      end
      subscription.service.mocked_subscriber = stub

      expect do
        subscription.labels = new_labels
      end.must_raise Google::Cloud::NotFoundError
    end

    it "raises NotFoundError when updating endpoint" do
      new_push_endpoint = "https://foo.bar/baz"

      stub = Object.new
      def stub.modify_push_config *args
        gax_error = Google::Gax::GaxError.new "not found"
        gax_error.instance_variable_set :@cause, GRPC::BadStatus.new(5, "not found")
        raise gax_error
      end
      subscription.service.mocked_subscriber = stub

      expect do
        subscription.endpoint = new_push_endpoint
      end.must_raise Google::Cloud::NotFoundError
    end

    it "raises NotFoundError when updating expires_in" do
      week_seconds = 60*60*24*7

      stub = Object.new
      def stub.update_subscription *args
        gax_error = Google::Gax::GaxError.new "not found"
        gax_error.instance_variable_set :@cause, GRPC::BadStatus.new(5, "not found")
        raise gax_error
      end
      subscription.service.mocked_subscriber = stub

      expect do
        subscription.expires_in = week_seconds
      end.must_raise Google::Cloud::NotFoundError
    end
  end
end
