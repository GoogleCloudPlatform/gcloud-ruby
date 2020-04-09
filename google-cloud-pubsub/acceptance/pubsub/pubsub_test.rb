# Copyright 2015 Google LLC
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

require "pubsub_helper"

# This test is a ruby version of gcloud-node's pubsub test.

describe Google::Cloud::PubSub, :pubsub do
  def retrieve_topic topic_name
    pubsub.get_topic(topic_name) || pubsub.create_topic(topic_name)
  end

  def retrieve_subscription topic, subscription_name
    topic.get_subscription(subscription_name) ||
      topic.subscribe(subscription_name)
  end

  def retrieve_snapshot project, subscription, snapshot_name
    existing = project.snapshots.detect { |s| s.name.split("/").last == snapshot_name }
    existing || subscription.create_snapshot(snapshot_name)
  end

  let(:new_topic_name)  {  $topic_names[0] }
  let(:topic_names)     {  $topic_names[3..6] }
  let(:reference_topic_name) { $topic_names[7] }
  let(:dead_letter_topic_name) { $topic_names[8] }
  let(:dead_letter_topic_name_2) { $topic_names[9] }
  let(:labels) { { "foo" => "bar" } }

  before do
    # create all topics
    topic_names.each do |topic_name|
      retrieve_topic topic_name
    end
  end

  it "should raise when endpoint is not the Pub/Sub service" do
    pubsub_invalid_endpoint = Google::Cloud::Pubsub.new endpoint: "example.com"
    expect { pubsub_invalid_endpoint.topics }.must_raise Google::Cloud::CanceledError
  end

  describe "Topic", :pubsub do
    it "should be listed" do
      topics = pubsub.topics.all
      topics.each do |topic|
        topic.must_be_kind_of Google::Cloud::PubSub::Topic
      end
    end

    it "should be created, updated and deleted" do
      topic = pubsub.create_topic new_topic_name, labels: labels
      topic.must_be_kind_of Google::Cloud::PubSub::Topic
      topic = pubsub.topic(topic.name)
      topic.wont_be :nil?
      topic.labels.must_equal labels
      topic.labels.must_be :frozen?
      topic.labels = {}
      topic.labels.must_be :empty?
      topic.delete
      pubsub.topic(topic.name).must_be :nil?
    end

    it "should publish a message" do
      data = "message from me"
      msg = pubsub.topic(topic_names.first).publish data, foo: :bar

      msg.wont_be :nil?
      msg.must_be_kind_of Google::Cloud::PubSub::Message
      msg.data.must_equal data
      msg.attributes["foo"].must_equal "bar"
    end

    it "should publish multiple messages" do
      msgs = pubsub.topic(topic_names.first).publish do |batch|
        batch.publish "first message"
        batch.publish "second message"
        batch.publish "third message", format: :text
      end

      msgs.wont_be :nil?
      msgs.count.must_equal 3
      msgs.each { |msg| msg.must_be_kind_of Google::Cloud::PubSub::Message }
    end
  end

  describe "Subscriptions on Project" do
    let(:topic) { retrieve_topic $topic_names[2] }

    before do
      3.times.each do |i|
        retrieve_subscription topic, "#{$topic_prefix}-sub-0#{i}"
      end
    end

    it "should list all subscriptions registered to the topic" do
      subscriptions = pubsub.subscriptions.all
      subscriptions.each do |subscription|
        # subscriptions on project are objects...
        subscription.must_be_kind_of Google::Cloud::PubSub::Subscription
      end
    end
  end

  describe "Subscription on Topic" do
    let(:topic) { retrieve_topic $topic_names[1] }
    let(:subs) { [ { name: "#{$topic_prefix}-sub1",
                     options: { deadline: 30 } },
                   { name: "#{$topic_prefix}-sub2",
                     options: { deadline: 60 } }
                 ] }

    before do
      subs.each do |sub|
        retrieve_subscription topic, sub[:name]
      end
    end

    it "should list all subscriptions registered to the topic" do
      subscriptions = topic.subscriptions.all
      subscriptions.count.must_be :>=, subs.count
      subscriptions.each do |subscription|
        # subscriptions on topic are strings...
        subscription.must_be_kind_of Google::Cloud::PubSub::Subscription
      end
    end

    it "should allow create and update of subscription with options" do
      # create
      subscription = topic.subscribe "#{$topic_prefix}-sub3", retain_acked: true, retention: 600, labels: labels
      subscription.wont_be :nil?
      subscription.must_be_kind_of Google::Cloud::PubSub::Subscription
      assert subscription.retain_acked
      subscription.retention.must_equal 600
      subscription.labels.must_equal labels
      subscription.labels.must_be :frozen?

      # update
      subscription.labels = {}
      subscription.labels.must_be :empty?
    ensure
      # delete
      subscription.delete
    end

    it "should not error when asking for a non-existent subscription" do
      subscription = topic.get_subscription "non-existent-subscription"
      subscription.must_be :nil?
    end

    it "should be able to pull and ack" do
      subscription = topic.subscribe "#{$topic_prefix}-sub4"
      subscription.wont_be :nil?
      subscription.must_be_kind_of Google::Cloud::PubSub::Subscription
      # No messages, should be empty
      received_messages = subscription.pull
      received_messages.must_be :empty?
      # Publish a new message
      msg = topic.publish "hello"
      msg.wont_be :nil?
      # Check it received the published message
      received_messages = pull_with_retry subscription
      received_messages.wont_be :empty?
      received_messages.count.must_equal 1
      received_message = received_messages.first
      received_message.wont_be :nil?
      received_message.delivery_attempt.must_be :nil?
      received_message.msg.data.must_equal msg.data
      received_message.msg.published_at.wont_be :nil?
      # Acknowledge the message
      subscription.ack received_message.ack_id
    ensure
      # Remove the subscription
      subscription.delete
    end

    it "should be able to pull same message again after ack by seeking to snapshot" do
      subscription = topic.subscribe "#{$topic_prefix}-sub5"
      subscription.wont_be :nil?
      subscription.must_be_kind_of Google::Cloud::PubSub::Subscription

      # No messages, should be empty
      received_messages = subscription.pull
      received_messages.must_be :empty?
      # Publish a new message
      msg = topic.publish "hello-#{rand(1000)}"
      msg.wont_be :nil?

      snapshot = subscription.create_snapshot labels: labels

      # Check it pulls the message
      received_messages = pull_with_retry subscription
      received_messages.wont_be :empty?
      received_messages.count.must_equal 1
      received_message = received_messages.first
      received_message.wont_be :nil?
      received_message.delivery_attempt.must_be :nil?
      received_message.msg.data.must_equal msg.data
      received_message.msg.published_at.wont_be :nil?
      # Acknowledge the message
      subscription.ack received_message.ack_id

      # No messages, should be empty
      received_messages = subscription.pull
      received_messages.must_be :empty?

      # Reset to the snapshot
      subscription.seek snapshot

      # Check it again pulls the message
      received_messages = pull_with_retry subscription
      received_messages.count.must_equal 1
      received_message = received_messages.first
      received_message.wont_be :nil?
      received_message.delivery_attempt.must_be :nil?
      received_message.msg.data.must_equal msg.data
      # Acknowledge the message
      subscription.ack received_message.ack_id
      # No messages, should be empty
      received_messages = subscription.pull
      received_messages.must_be :empty?

      # No messages, should be empty
      received_messages = subscription.pull
      received_messages.must_be :empty?

      snapshot.labels.must_equal labels
      snapshot.labels.must_be :frozen?
      snapshot.labels = {}
      snapshot.labels.must_be :empty?
    ensure
      # Remove the subscription
      subscription.delete
    end

    if $project_number
      it "should be able to direct messages to a dead letter topic" do
        dead_letter_topic = retrieve_topic dead_letter_topic_name
        dead_letter_subscription = dead_letter_topic.subscribe "#{$topic_prefix}-dead-letter-sub1"

        # Dead Letter Queue (DLQ) testing requires IAM bindings to the Cloud Pub/Sub service account that is
        # automatically created and managed by the service team in a private project.
        service_account_email = "serviceAccount:service-#{$project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"

        dead_letter_topic.policy { |p| p.add "roles/pubsub.publisher", service_account_email }
        dead_letter_subscription.policy { |p| p.add "roles/pubsub.subscriber", service_account_email }

        # create
        subscription = topic.subscribe "#{$topic_prefix}-sub6", dead_letter_topic: dead_letter_topic, dead_letter_max_delivery_attempts: 6
        subscription.dead_letter_max_delivery_attempts.must_equal 6
        subscription.dead_letter_topic.reload!.name.must_equal dead_letter_topic.name

        # update
        subscription.dead_letter_max_delivery_attempts = 5
        subscription.dead_letter_max_delivery_attempts.must_equal 5
        dead_letter_topic_2 = retrieve_topic dead_letter_topic_name_2
        dead_letter_subscription_2 = dead_letter_topic_2.subscribe "#{$topic_prefix}-dead-letter-sub2"
        subscription.dead_letter_topic = dead_letter_topic_2
        subscription.dead_letter_topic.reload!.name.must_equal dead_letter_topic_2.name

        # Publish a new message
        msg = topic.publish "dead-letter-#{rand(1000)}"
        msg.wont_be :nil?

        # Check it pulls the message
        (1..7).each do |i|
          received_messages = pull_with_retry subscription
          received_messages.count.must_equal 1
          received_message = received_messages.first
          received_message.msg.data.must_equal msg.data
          received_message.delivery_attempt.must_be :>, 0
          received_message.nack!
        end

        # Check the dead letter subscription pulls the message
        received_messages = dead_letter_subscription.pull
        received_messages.wont_be :empty?
        received_messages.count.must_equal 1
        received_message = received_messages.first
        received_message.wont_be :nil?
        received_message.msg.data.must_equal msg.data
        received_message.delivery_attempt.must_be :nil?
      ensure
        # Remove the subscription
        subscription.delete
        dead_letter_subscription.delete
      end
    end

    def pull_with_retry sub
      received_messages = []
      retries = 0
      while retries <= 5 do
        received_messages = sub.pull
        break if received_messages.any?
        retries += 1
        puts "the subscription does not have the message yet. sleeping for #{retries*retries} second(s) and retrying."
        sleep retries*retries
      end
      received_messages
    end
  end

  describe "IAM Policies and Permissions" do
    let(:topic) { retrieve_topic $topic_names[3] }
    let(:subscription) { retrieve_subscription topic, "#{$topic_prefix}-subIAM" }
    let(:service_account) { pubsub.service.credentials.client.issuer }

    it "allows policy to be updated on a topic" do
      # Check permissions first
      roles = ["pubsub.topics.getIamPolicy", "pubsub.topics.setIamPolicy"]
      permissions = topic.test_permissions roles
      skip "Don't have permissions to get/set topic's policy" unless permissions == roles

      topic.policy.must_be_kind_of Google::Cloud::PubSub::Policy

      # We need a valid service account in order to update the policy
      service_account.wont_be :nil?
      role = "roles/pubsub.publisher"
      member = "serviceAccount:#{service_account}"
      topic.policy do |p|
        p.add role, member
        p.add role, member # duplicate member will not be added to request
      end

      role_member = topic.policy.role(role).select { |x| x == member }
      role_member.size.must_equal 1
    end

    it "allows policy to be updated on a subscription" do
      # Check permissions first
      roles = ["pubsub.subscriptions.getIamPolicy", "pubsub.subscriptions.setIamPolicy"]
      permissions = subscription.test_permissions roles
      skip "Don't have permissions to get/set subscription's policy" unless permissions == roles

      subscription.policy.must_be_kind_of Google::Cloud::PubSub::Policy

      # We need a valid service account in order to update the policy
      service_account.wont_be :nil?
      role = "roles/pubsub.subscriber"
      member = "serviceAccount:#{service_account}"
      subscription.policy do |p|
        p.add role, member
      end

      subscription.policy.role(role).must_include member
    end

    it "allows permissions to be tested on a topic" do
      roles = ["pubsub.topics.get", "pubsub.topics.publish"]
      permissions = topic.test_permissions roles
      permissions.must_equal roles
    end

    it "allows permissions to be tested on a subscription" do
      roles = ["pubsub.subscriptions.consume", "pubsub.subscriptions.get"]
      permissions = subscription.test_permissions roles
      permissions.must_equal roles
    end
  end

  describe "Snapshots on Project" do
    let(:topic) { retrieve_topic $topic_names[4] }
    let(:subscription) { retrieve_subscription topic, "#{$topic_prefix}-subSnapshots" }

    before do
      3.times.each do |i|
        retrieve_snapshot pubsub, subscription, $snapshot_names[i]
      end
    end

    it "should list all snapshots registered to the project" do
      snapshots = pubsub.snapshots.all
      snapshots.each do |snapshot|
        # snapshots on project are objects...
        snapshot.must_be_kind_of Google::Cloud::PubSub::Snapshot
      end
    end
  end
end
