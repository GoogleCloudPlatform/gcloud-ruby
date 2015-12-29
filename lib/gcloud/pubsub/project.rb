#--
# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "gcloud/gce"
require "gcloud/pubsub/connection"
require "gcloud/pubsub/credentials"
require "gcloud/pubsub/errors"
require "gcloud/pubsub/topic"

module Gcloud
  module Pubsub
    ##
    # # Project
    #
    # Represents the project that pubsub messages are pushed to and pulled from.
    # {Topic} is a named resource to which messages are sent by publishers.
    # {Subscription} is a named resource representing the stream of messages
    # from a single, specific topic, to be delivered to the subscribing
    # application. {Message} is a combination of data and attributes that a
    # publisher sends to a topic and is eventually delivered to subscribers.
    #
    # See {Gcloud#pubsub}
    #
    # @example
    #   require "gcloud"
    #
    #   gcloud = Gcloud.new
    #   pubsub = gcloud.pubsub
    #
    #   topic = pubsub.topic "my-topic"
    #   topic.publish "task completed"
    #
    class Project
      ##
      # @private The Connection object.
      attr_accessor :connection

      ##
      # @private Creates a new Connection instance.
      def initialize project, credentials
        project = project.to_s # Always cast to a string
        fail ArgumentError, "project is missing" if project.empty?
        @connection = Connection.new project, credentials
      end

      # The Pub/Sub project connected to.
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new "my-todo-project",
      #                       "/path/to/keyfile.json"
      #   pubsub = gcloud.pubsub
      #
      #   pubsub.project #=> "my-todo-project"
      #
      def project
        connection.project
      end

      ##
      # @private Default project.
      def self.default_project
        ENV["PUBSUB_PROJECT"] ||
          ENV["GCLOUD_PROJECT"] ||
          ENV["GOOGLE_CLOUD_PROJECT"] ||
          Gcloud::GCE.project_id
      end

      ##
      # Retrieves topic by name.
      #
      # The topic will be created if the topic does not exist and the
      # +autocreate+ option is set to true.
      #
      # @param [String] topic_name Name of a topic.
      # @param [Boolean] autocreate Flag to control whether the requested topic
      #   will be created if it does not exist. Ignored if +skip_lookup+ is
      #   +true+. The default value is +false+.
      # @param [String] project If the topic belongs to a project other than the
      #   one currently connected to, the alternate project ID can be specified
      #   here.
      # @param [Boolean] skip_lookup Optionally create a {Topic} object without
      #   verifying the topic resource exists on the Pub/Sub service. Calls made
      #   on this object will raise errors if the topic resource does not exist.
      #   Default is +false+.
      #
      # @return [Gcloud::Pubsub::Topic, nil] Returns +nil+ if topic does not
      #   exist. Will return a newly created{ Gcloud::Pubsub::Topic} if the
      #   topic does not exist and +autocreate+ is set to +true+.
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #   topic = pubsub.topic "existing-topic"
      #
      # @example By default +nil+ will be returned if the topic does not exist.
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #   topic = pubsub.topic "non-existing-topic" #=> nil
      #
      # @example With the +autocreate+ option set to +true+.
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #   topic = pubsub.topic "non-existing-topic", autocreate: true
      #
      # @example Create a topic in a different project with the +project+ flag.
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #   topic = pubsub.topic "another-topic", project: "another-project"
      #
      # @example Skip the lookup against the service with +skip_lookup+:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #   topic = pubsub.topic "another-topic", skip_lookup: true
      #
      def topic topic_name, autocreate: nil, project: nil, skip_lookup: nil
        ensure_connection!
        options = { project: project }
        return Topic.new_lazy(topic_name, connection, options) if skip_lookup
        resp = connection.get_topic topic_name
        return Topic.from_gapi(resp.data, connection) if resp.success?
        if resp.status == 404
          return create_topic(topic_name) if autocreate
          return nil
        end
        fail ApiError.from_response(resp)
      end
      alias_method :get_topic, :topic
      alias_method :find_topic, :topic

      ##
      # Creates a new topic.
      #
      # @param [String] topic_name Name of a topic.
      #
      # @return [Gcloud::Pubsub::Topic]
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #   topic = pubsub.create_topic "my-topic"
      #
      def create_topic topic_name
        ensure_connection!
        resp = connection.create_topic topic_name
        if resp.success?
          Topic.from_gapi resp.data, connection
        else
          fail ApiError.from_response(resp)
        end
      end
      alias_method :new_topic, :create_topic

      ##
      # Retrieves a list of topics for the given project.
      #
      # @param [String] token The +token+ value returned by the last call to
      #   +topics+; indicates that this is a continuation of a call, and that
      #   the system should return the next page of data.
      # @param [Integer] max Maximum number of topics to return.
      #
      # @return [Array<Gcloud::Pubsub::Topic>] (See
      #   {Gcloud::Pubsub::Topic::List})
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   topics = pubsub.topics
      #   topics.each do |topic|
      #     puts topic.name
      #   end
      #
      # @example With pagination: (See {Topic::List#token})
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   all_topics = []
      #   tmp_topics = pubsub.topics
      #   while tmp_topics.any? do
      #     tmp_topics.each do |topic|
      #       all_topics << topic
      #     end
      #     # break loop if no more topics available
      #     break if tmp_topics.token.nil?
      #     # get the next group of topics
      #     tmp_topics = pubsub.topics token: tmp_topics.token
      #   end
      #
      def topics token: nil, max: nil
        ensure_connection!
        options = { token: token, max: max }
        resp = connection.list_topics options
        if resp.success?
          Topic::List.from_response resp, connection
        else
          fail ApiError.from_response(resp)
        end
      end
      alias_method :find_topics, :topics
      alias_method :list_topics, :topics

      ##
      # Publishes one or more messages to the given topic. The topic will be
      # created if the topic does previously not exist and the +autocreate+
      # option is provided.
      #
      # A note about auto-creating the topic: Any message published to a topic
      # without a subscription will be lost.
      #
      # @param [String] topic_name Name of a topic.
      # @param [String] data The message data.
      # @param [Hash] attributes Optional attributes for the message.
      # @option attributes [Boolean] :autocreate Flag to control whether the
      #   provided topic will be created if it does not exist.
      #
      # @return [Message, Array<Message>] Returns the published message when
      #   called without a block, or an array of messages when called with a
      #   block.
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   msg = pubsub.publish "my-topic", "new-message"
      #
      # @example Additionally, a message can be published with attributes:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   msg = pubsub.publish "my-topic", "new-message", foo: :bar,
      #                                                   this: :that
      #
      # @example Multiple messages can be sent at the same time using a block:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   msgs = pubsub.publish "my-topic" do |batch|
      #     batch.publish "new-message-1", foo: :bar
      #     batch.publish "new-message-2", foo: :baz
      #     batch.publish "new-message-3", foo: :bif
      #   end
      #
      # @example With +autocreate+:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   msg = pubsub.publish "new-topic", "new-message", autocreate: true
      #
      def publish topic_name, data = nil, attributes = {}
        # Fix parameters
        if data.is_a?(::Hash) && attributes.empty?
          attributes = data
          data = nil
        end
        # extract autocreate option
        autocreate = attributes.delete :autocreate
        ensure_connection!
        batch = Topic::Batch.new data, attributes
        yield batch if block_given?
        return nil if batch.messages.count.zero?
        publish_batch_messages topic_name, batch, autocreate
      end

      ##
      # Creates a new {Subscription} object for the provided topic. The topic
      # will be created if the topic does previously not exist and the
      # +autocreate+ option is provided.
      #
      # @param [String] topic_name Name of a topic.
      # @param [String] subscription_name Name of the new subscription. Must
      #   start with a letter, and contain only letters ([A-Za-z]), numbers
      #   ([0-9], dashes (-), underscores (_), periods (.), tildes (~), plus (+)
      #   or percent signs (%). It must be between 3 and 255 characters in
      #   length, and it must not start with "goog".
      # @param [Integer] deadline The maximum number of seconds after a
      #   subscriber receives a message before the subscriber should acknowledge
      #   the message.
      # @param [String] endpoint A URL locating the endpoint to which messages
      #   should be pushed.
      # @param [String] autocreate Flag to control whether the topic will be
      #   created if it does not exist.
      #
      # @return [Gcloud::Pubsub::Subscription]
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   sub = pubsub.subscribe "my-topic", "my-topic-sub"
      #   puts sub.name # => "my-topic-sub"
      #
      # @example The name is optional, and will be generated if not given.
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   sub = pubsub.subscribe "my-topic"
      #   puts sub.name # => "generated-sub-name"
      #
      # @example Wait 2 minutes for acknowledgement and push all to an endpoint:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   sub = pubsub.subscribe "my-topic", "my-topic-sub",
      #                          deadline: 120,
      #                          endpoint: "https://example.com/push"
      #
      # @example With +autocreate+:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   sub = pubsub.subscribe "new-topic", "new-topic-sub", autocreate: true
      #
      def subscribe topic_name, subscription_name, deadline: nil, endpoint: nil,
                    autocreate: nil
        ensure_connection!
        options = { deadline: deadline, endpoint: endpoint }
        resp = connection.create_subscription topic_name,
                                              subscription_name, options
        return Subscription.from_gapi(resp.data, connection) if resp.success?
        if autocreate && resp.status == 404
          create_topic topic_name
          return subscribe(topic_name, subscription_name,
                           deadline: deadline, endpoint: endpoint,
                           autocreate: false)
        end
        fail ApiError.from_response(resp)
      end
      alias_method :create_subscription, :subscribe
      alias_method :new_subscription, :subscribe

      ##
      # Retrieves subscription by name.
      #
      # @param [String] subscription_name Name of a subscription.
      # @param [String] project If the subscription belongs to a project other
      #   than the one currently connected to, the alternate project ID can be
      #   specified here.
      # @param [Boolean] skip_lookup Optionally create a {Subscription} object
      #   without verifying the subscription resource exists on the Pub/Sub
      #   service. Calls made on this object will raise errors if the service
      #   resource does not exist. Default is +false+.
      #
      # @return [Gcloud::Pubsub::Subscription, nil] Returns +nil+ if the
      #   subscription does not exist
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   subscription = pubsub.subscription "my-sub"
      #   puts subscription.name
      #
      # @example Skip the lookup against the service with +skip_lookup+:
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   # No API call is made to retrieve the subscription information.
      #   subscription = pubsub.subscription "my-sub", skip_lookup: true
      #   puts subscription.name
      #
      def subscription subscription_name, project: nil, skip_lookup: nil
        ensure_connection!
        options = { project: project }
        if skip_lookup
          return Subscription.new_lazy(subscription_name, connection, options)
        end
        resp = connection.get_subscription subscription_name
        return Subscription.from_gapi(resp.data, connection) if resp.success?
        return nil if resp.status == 404
        fail ApiError.from_response(resp)
      end
      alias_method :get_subscription, :subscription
      alias_method :find_subscription, :subscription

      ##
      # Retrieves a list of subscriptions for the given project.
      #
      # @param [String] prefix Filter results to subscriptions whose names begin
      #   with this prefix.
      # @param [String] token A previously-returned page token representing part
      #   of the larger set of results to view.
      # @param [Integer] max Maximum number of subscriptions to return.
      #
      # @return [Array<Gcloud::Pubsub::Subscription>] (See
      #   {Gcloud::Pubsub::Subscription::List})
      #
      # @example
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   subscriptions = pubsub.subscriptions
      #   subscriptions.each do |subscription|
      #     puts subscription.name
      #   end
      #
      # @example With pagination: (See {Subscription::List#token})
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   pubsub = gcloud.pubsub
      #
      #   all_subs = []
      #   tmp_subs = pubsub.subscriptions
      #   while tmp_subs.any? do
      #     tmp_subs.each do |subscription|
      #       all_subs << subscription
      #     end
      #     # break loop if no more subscriptions available
      #     break if tmp_subs.token.nil?
      #     # get the next group of subscriptions
      #     tmp_subs = pubsub.subscriptions token: tmp_subs.token
      #   end
      #
      def subscriptions prefix: nil, token: nil, max: nil
        ensure_connection!
        options = { prefix: prefix, token: token, max: max }
        resp = connection.list_subscriptions options
        if resp.success?
          Subscription::List.from_response resp, connection
        else
          fail ApiError.from_response(resp)
        end
      end
      alias_method :find_subscriptions, :subscriptions
      alias_method :list_subscriptions, :subscriptions

      protected

      ##
      # Raise an error unless an active connection is available.
      def ensure_connection!
        fail "Must have active connection" unless connection
      end

      ##
      # Call the publish API with arrays of data data and attrs.
      def publish_batch_messages topic_name, batch, autocreate = false
        resp = connection.publish topic_name, batch.messages
        if resp.success?
          batch.to_gcloud_messages resp.data["messageIds"]
        elsif autocreate && resp.status == 404
          create_topic topic_name
          publish_batch_messages topic_name, batch, false
        else
          fail ApiError.from_response(resp)
        end
      end
    end
  end
end
