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


require "google/cloud/pubsub/convert"
require "google/cloud/errors"
require "google/cloud/pubsub/subscription/list"
require "google/cloud/pubsub/subscription/push_config"
require "google/cloud/pubsub/received_message"
require "google/cloud/pubsub/snapshot"
require "google/cloud/pubsub/subscriber"

module Google
  module Cloud
    module PubSub
      ##
      # # Subscription
      #
      # A named resource representing the stream of messages from a single,
      # specific {Topic}, to be delivered to the subscribing application.
      #
      # @example
      #   require "google/cloud/pubsub"
      #
      #   pubsub = Google::Cloud::PubSub.new
      #
      #   sub = pubsub.subscription "my-topic-sub"
      #   subscriber = sub.listen do |received_message|
      #     # process message
      #     received_message.acknowledge!
      #   end
      #
      #   # Start background threads that will call the block passed to listen.
      #   subscriber.start
      #
      #   # Shut down the subscriber when ready to stop receiving messages.
      #   subscriber.stop.wait!
      #
      class Subscription
        ##
        # @private The Service object.
        attr_accessor :service

        ##
        # @private The gRPC Google::Cloud::PubSub::V1::Subscription object.
        attr_accessor :grpc

        ##
        # @private Create an empty {Subscription} object.
        def initialize
          @service = nil
          @grpc = nil
          @resource_name = nil
          @exists = nil
        end

        ##
        # The name of the subscription.
        #
        # @return [String]
        def name
          return @resource_name if reference?
          @grpc.name
        end

        ##
        # The {Topic} from which this subscription receives messages.
        #
        # Makes an API call to retrieve the topic information when called on a
        # reference object. See {#reference?}.
        #
        # @return [Topic]
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   sub.topic.name #=> "projects/my-project/topics/my-topic"
        #
        def topic
          ensure_grpc!
          Topic.from_name @grpc.topic, service
        end

        ##
        # This value is the maximum number of seconds after a subscriber
        # receives a message before the subscriber should acknowledge the
        # message.
        #
        # Makes an API call to retrieve the deadline value when called on a
        # reference object. See {#reference?}.
        #
        # @return [Integer]
        def deadline
          ensure_grpc!
          @grpc.ack_deadline_seconds
        end

        ##
        # Sets the maximum number of seconds after a subscriber
        # receives a message before the subscriber should acknowledge the
        # message.
        #
        # @param [Integer] new_deadline The new deadline value.
        #
        def deadline= new_deadline
          update_grpc = Google::Cloud::PubSub::V1::Subscription.new \
            name: name, ack_deadline_seconds: new_deadline
          @grpc = service.update_subscription update_grpc,
                                              :ack_deadline_seconds
          @resource_name = nil
        end

        ##
        # Indicates whether to retain acknowledged messages. If `true`, then
        # messages are not expunged from the subscription's backlog, even if
        # they are acknowledged, until they fall out of the {#retention} window.
        # Default is `false`.
        #
        # Makes an API call to retrieve the retain_acked value when called on a
        # reference object. See {#reference?}.
        #
        # @return [Boolean] Returns `true` if acknowledged messages are
        #   retained.
        #
        def retain_acked
          ensure_grpc!
          @grpc.retain_acked_messages
        end

        ##
        # Sets whether to retain acknowledged messages.
        #
        # @param [Boolean] new_retain_acked The new retain acknowledged messages
        #   value.
        #
        def retain_acked= new_retain_acked
          update_grpc = Google::Cloud::PubSub::V1::Subscription.new \
            name: name, retain_acked_messages: !(!new_retain_acked)
          @grpc = service.update_subscription update_grpc,
                                              :retain_acked_messages
          @resource_name = nil
        end

        ##
        # How long to retain unacknowledged messages in the subscription's
        # backlog, from the moment a message is published. If
        # {#retain_acked} is `true`, then this also configures the retention of
        # acknowledged messages, and thus configures how far back in time a
        # {#seek} can be done. Cannot be more than 604,800 seconds (7 days) or
        # less than 600 seconds (10 minutes). Default is 604,800 seconds (7
        # days).
        #
        # Makes an API call to retrieve the retention value when called on a
        # reference object. See {#reference?}.
        #
        # @return [Numeric] The message retention duration in seconds.
        #
        def retention
          ensure_grpc!
          Convert.duration_to_number @grpc.message_retention_duration
        end

        ##
        # Sets the message retention duration in seconds.
        #
        # @param [Numeric] new_retention The new retention value.
        #
        def retention= new_retention
          new_retention_duration = Convert.number_to_duration new_retention
          update_grpc = Google::Cloud::PubSub::V1::Subscription.new \
            name: name, message_retention_duration: new_retention_duration
          @grpc = service.update_subscription update_grpc,
                                              :message_retention_duration
          @resource_name = nil
        end

        ##
        # Returns the URL locating the endpoint to which messages should be
        # pushed. For example, a Webhook endpoint might use
        # "https://example.com/push".
        #
        # Makes an API call to retrieve the endpoint value when called on a
        # reference object. See {#reference?}.
        #
        # @return [String]
        #
        def endpoint
          ensure_grpc!
          @grpc.push_config.push_endpoint if @grpc.push_config
        end

        ##
        # Sets the URL locating the endpoint to which messages should be pushed.
        # For example, a Webhook endpoint might use "https://example.com/push".
        #
        # @param [String] new_endpoint The new endpoint value.
        #
        def endpoint= new_endpoint
          ensure_service!
          service.modify_push_config name, new_endpoint, {}

          return if reference?

          @grpc.push_config = Google::Cloud::PubSub::V1::PushConfig.new(
            push_endpoint: new_endpoint,
            attributes:    {}
          )
        end

        ##
        # Inspect the Subscription's push configuration settings. The
        # configuration can be changed by modifying the values in the method's
        # block.
        #
        # Subscription objects that are reference only will return an empty
        # {Subscription::PushConfig} object, which can be configured and saved
        # using the method's block. Unlike {#endpoint}, which will retrieve the
        # full resource from the API before returning. To get the actual values
        # for a reference object, call {#reload!} before calling {#push_config}.
        #
        # @yield [push_config] a block for modifying the push configuration
        # @yieldparam [Subscription::PushConfig] push_config the push
        #   configuration
        #
        # @return [Subscription::PushConfig]
        #
        def push_config
          ensure_service!

          orig_config = reference? ? nil : @grpc.push_config
          config = PushConfig.from_grpc orig_config

          if block_given?
            old_config = config.to_grpc.dup
            yield config
            new_config = config.to_grpc

            if old_config != new_config # has the object been changed?
              update_grpc = Google::Cloud::PubSub::V1::Subscription.new \
                name: name, push_config: new_config
              @grpc = service.update_subscription update_grpc, :push_config
            end
          end

          config.freeze
        end

        ##
        # A hash of user-provided labels associated with this subscription.
        # Labels can be used to organize and group subscriptions.See [Creating
        # and Managing Labels](https://cloud.google.com/pubsub/docs/labels).
        #
        # The returned hash is frozen and changes are not allowed. Use
        # {#labels=} to update the labels for this subscription.
        #
        # Makes an API call to retrieve the labels value when called on a
        # reference object. See {#reference?}.
        #
        # @return [Hash] The frozen labels hash.
        #
        def labels
          ensure_grpc!
          @grpc.labels.to_h.freeze
        end

        ##
        # Sets the hash of user-provided labels associated with this
        # subscription. Labels can be used to organize and group subscriptions.
        # Label keys and values can be no longer than 63 characters, can only
        # contain lowercase letters, numeric characters, underscores and dashes.
        # International characters are allowed. Label values are optional. Label
        # keys must start with a letter and each label in the list must have a
        # different key. See [Creating and Managing
        # Labels](https://cloud.google.com/pubsub/docs/labels).
        #
        # @param [Hash] new_labels The new labels hash.
        #
        def labels= new_labels
          raise ArgumentError, "Value must be a Hash" if new_labels.nil?
          update_grpc = Google::Cloud::PubSub::V1::Subscription.new \
            name: name, labels: new_labels
          @grpc = service.update_subscription update_grpc, :labels
          @resource_name = nil
        end

        ##
        # The duration (in seconds) for when a subscription expires after the
        # subscription goes inactive. A subscription is considered active as
        # long as any connected subscriber is successfully consuming messages
        # from the subscription or is issuing operations on the subscription.
        #
        # If {#expires_in=} is not set, a *default* value of of 31 days will be
        # used. The minimum allowed value is 1 day.
        #
        # Makes an API call to retrieve the labels value when called on a
        # reference object. See {#reference?}.
        #
        # @return [Numeric, nil] The expiration duration, or `nil` if unset.
        #
        def expires_in
          ensure_grpc!

          return nil if @grpc.expiration_policy.nil?

          Convert.duration_to_number @grpc.expiration_policy.ttl
        end

        ##
        # Sets the duration (in seconds) for when a subscription expires after
        # the subscription goes inactive.
        #
        # See also {#expires_in}.
        #
        # @param [Numeric, nil] ttl The expiration duration in seconds, or `nil`
        #   to unset.
        #
        def expires_in= ttl
          new_expiration_policy = Google::Pubsub::V1::ExpirationPolicy.new(
            ttl: Convert.number_to_duration(ttl)
          )

          update_grpc = Google::Cloud::PubSub::V1::Subscription.new \
            name: name, expiration_policy: new_expiration_policy
          @grpc = service.update_subscription update_grpc, :expiration_policy
          @resource_name = nil
        end

        ##
        # Determines whether the subscription exists in the Pub/Sub service.
        #
        # Makes an API call to determine whether the subscription resource
        # exists when called on a reference object. See {#reference?}.
        #
        # @return [Boolean]
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   sub.exists? #=> true
        #
        def exists?
          # Always true if the object is not set as reference
          return true unless reference?
          # If we have a value, return it
          return @exists unless @exists.nil?
          ensure_grpc!
          @exists = true
        rescue Google::Cloud::NotFoundError
          @exists = false
        end

        ##
        # Deletes an existing subscription.
        # All pending messages in the subscription are immediately dropped.
        #
        # @return [Boolean] Returns `true` if the subscription was deleted.
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   sub.delete
        #
        def delete
          ensure_service!
          service.delete_subscription name
          true
        end

        ##
        # Pulls messages from the server. Returns an empty list if there are no
        # messages available in the backlog. Raises an ApiError with status
        # `UNAVAILABLE` if there are too many concurrent pull requests pending
        # for the given subscription.
        #
        # See also {#listen} for the preferred way to process messages as they
        # become available.
        #
        # @param [Boolean] immediate When `true` the system will respond
        #   immediately even if it is not able to return messages. When `false`
        #   the system is allowed to wait until it can return least one message.
        #   No messages are returned when a request times out. The default value
        #   is `true`.
        #
        #   See also {#listen} for the preferred way to process messages as they
        #   become available.
        # @param [Integer] max The maximum number of messages to return for this
        #   request. The Pub/Sub system may return fewer than the number
        #   specified. The default value is `100`, the maximum value is `1000`.
        #
        # @return [Array<Google::Cloud::PubSub::ReceivedMessage>]
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   sub.pull.each { |received_message| received_message.acknowledge! }
        #
        # @example A maximum number of messages returned can also be specified:
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   sub.pull(max: 10).each do |received_message|
        #     received_message.acknowledge!
        #   end
        #
        # @example The call can block until messages are available:
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   received_messages = sub.pull immediate: false
        #   received_messages.each do |received_message|
        #     received_message.acknowledge!
        #   end
        #
        def pull immediate: true, max: 100
          ensure_service!
          options = { immediate: immediate, max: max }
          list_grpc = service.pull name, options
          Array(list_grpc.received_messages).map do |msg_grpc|
            ReceivedMessage.from_grpc msg_grpc, self
          end
        rescue Google::Cloud::DeadlineExceededError
          []
        end

        ##
        # Pulls from the server while waiting for messages to become available.
        # This is the same as:
        #
        #   subscription.pull immediate: false
        #
        # See also {#listen} for the preferred way to process messages as they
        # become available.
        #
        # @param [Integer] max The maximum number of messages to return for this
        #   request. The Pub/Sub system may return fewer than the number
        #   specified. The default value is `100`, the maximum value is `1000`.
        #
        # @return [Array<Google::Cloud::PubSub::ReceivedMessage>]
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   received_messages = sub.wait_for_messages
        #   received_messages.each do |received_message|
        #     received_message.acknowledge!
        #   end
        #
        def wait_for_messages max: 100
          pull immediate: false, max: max
        end

        ##
        # Create a {Subscriber} object that receives  and processes messages
        # using the code provided in the callback.
        #
        # @param [Numeric] deadline The default number of seconds the stream
        #   will hold received messages before modifying the message's ack
        #   deadline. The minimum is 10, the maximum is 600. Default is
        #   {#deadline}. Optional.
        #
        #   Makes an API call to retrieve the deadline value when called on a
        #   reference object. See {#reference?}.
        # @param [Integer] streams The number of concurrent streams to open to
        #   pull messages from the subscription. Default is 4. Optional.
        # @param [Integer] inventory The number of received messages to be
        #   collected by subscriber. Default is 1,000. Optional.
        # @param [Hash] threads The number of threads to create to handle
        #   concurrent calls by each stream opened by the subscriber. Optional.
        #
        #   Hash keys and values may include the following:
        #
        #     * `:callback` (Integer) The number of threads used to handle the
        #       received messages. Default is 8.
        #     * `:push` (Integer) The number of threads to handle
        #       acknowledgement ({ReceivedMessage#ack!}) and modify ack deadline
        #       messages ({ReceivedMessage#nack!},
        #       {ReceivedMessage#modify_ack_deadline!}). Default is 4.
        #
        # @yield [received_message] a block for processing new messages
        # @yieldparam [ReceivedMessage] received_message the newly received
        #   message
        #
        # @return [Subscriber]
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #
        #   subscriber = sub.listen do |received_message|
        #     # process message
        #     received_message.acknowledge!
        #   end
        #
        #   # Start background threads that will call block passed to listen.
        #   subscriber.start
        #
        #   # Shut down the subscriber when ready to stop receiving messages.
        #   subscriber.stop.wait!
        #
        # @example Configuring to increase concurrent callbacks:
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #
        #   subscriber = sub.listen threads: { callback: 16 } do |rec_message|
        #     # store the message somewhere before acknowledging
        #     store_in_backend rec_message.data # takes a few seconds
        #     rec_message.acknowledge!
        #   end
        #
        #   # Start background threads that will call block passed to listen.
        #   subscriber.start
        #
        def listen deadline: nil, streams: nil, inventory: nil, threads: {},
                   &block
          ensure_service!
          deadline ||= self.deadline

          Subscriber.new name, block, deadline: deadline, streams: streams,
                                      inventory: inventory, threads: threads,
                                      service: service
        end

        ##
        # Acknowledges receipt of a message. After an ack,
        # the Pub/Sub system can remove the message from the subscription.
        # Acknowledging a message whose ack deadline has expired may succeed,
        # although the message may have been sent again.
        # Acknowledging a message more than once will not result in an error.
        # This is only used for messages received via pull.
        #
        # See also {ReceivedMessage#acknowledge!}.
        #
        # @param [ReceivedMessage, String] messages One or more
        #   {ReceivedMessage} objects or ack_id values.
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   received_messages = sub.pull
        #   sub.acknowledge received_messages
        #
        def acknowledge *messages
          ack_ids = coerce_ack_ids messages
          return true if ack_ids.empty?
          ensure_service!
          service.acknowledge name, *ack_ids
          true
        end
        alias ack acknowledge

        ##
        # Modifies the acknowledge deadline for messages.
        #
        # This indicates that more time is needed to process the messages, or to
        # make the messages available for redelivery if the processing was
        # interrupted.
        #
        # See also {ReceivedMessage#modify_ack_deadline!}.
        #
        # @param [Integer] new_deadline The new ack deadline in seconds from the
        #   time this request is sent to the Pub/Sub system. Must be >= 0. For
        #   example, if the value is `10`, the new ack deadline will expire 10
        #   seconds after the call is made. Specifying `0` may immediately make
        #   the message available for another pull request.
        # @param [ReceivedMessage, String] messages One or more
        #   {ReceivedMessage} objects or ack_id values.
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.subscription "my-topic-sub"
        #   received_messages = sub.pull
        #   sub.modify_ack_deadline 120, received_messages
        #
        def modify_ack_deadline new_deadline, *messages
          ack_ids = coerce_ack_ids messages
          ensure_service!
          service.modify_ack_deadline name, ack_ids, new_deadline
          true
        end

        ##
        # Creates a new {Snapshot} from the subscription. The created snapshot
        # is guaranteed to retain:
        #
        # * The existing backlog on the subscription. More precisely, this is
        #   defined as the messages in the subscription's backlog that are
        #   unacknowledged upon the successful completion of the
        #   `create_snapshot` operation; as well as:
        # * Any messages published to the subscription's topic following the
        #   successful completion of the `create_snapshot` operation.
        #
        # @param [String, nil] snapshot_name Name of the new snapshot. If the
        #   name is not provided, the server will assign a random name
        #   for this snapshot on the same project as the subscription. The
        #   format is `projects/{project}/snapshots/{snap}`. The name must start
        #   with a letter, and contain only letters ([A-Za-z]), numbers
        #   ([0-9], dashes (-), underscores (_), periods (.), tildes (~), plus
        #   (+) or percent signs (%). It must be between 3 and 255 characters in
        #   length, and it must not start with "goog". Optional.
        # @param [Hash] labels A hash of user-provided labels associated with
        #   the snapshot. You can use these to organize and group your
        #   snapshots. Label keys and values can be no longer than 63
        #   characters, can only contain lowercase letters, numeric characters,
        #   underscores and dashes. International characters are allowed. Label
        #   values are optional. Label keys must start with a letter and each
        #   label in the list must have a different key. See [Creating and
        #   Managing Labels](https://cloud.google.com/pubsub/docs/labels).
        #
        # @return [Google::Cloud::PubSub::Snapshot]
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-sub"
        #
        #   snapshot = sub.create_snapshot "my-snapshot"
        #   snapshot.name #=> "projects/my-project/snapshots/my-snapshot"
        #
        # @example Without providing a name:
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-sub"
        #
        #   snapshot = sub.create_snapshot
        #   snapshot.name #=> "projects/my-project/snapshots/gcr-analysis-..."
        #
        def create_snapshot snapshot_name = nil, labels: nil
          ensure_service!
          grpc = service.create_snapshot name, snapshot_name, labels: labels
          Snapshot.from_grpc grpc, service
        end
        alias new_snapshot create_snapshot

        ##
        # Resets the subscription's backlog to a given {Snapshot} or to a point
        # in time, whichever is provided in the request.
        #
        # @param [Snapshot, String, Time] snapshot The `Snapshot` instance,
        #   snapshot name, or time to which to perform the seek.
        #   If the argument is a snapshot, the snapshot's topic must be the
        #   same as that of the subscription. If it is a time, messages retained
        #   in the subscription that were published before this time are marked
        #   as acknowledged, and messages retained in the subscription that were
        #   published after this time are marked as unacknowledged. Note that
        #   this operation affects only those messages retained in the
        #   subscription. For example, if the time corresponds to a point before
        #   the message retention window (or to a point before the system's
        #   notion of the subscription creation time), only retained messages
        #   will be marked as unacknowledged, and already-expunged messages will
        #   not be restored.
        #
        # @return [Boolean] Returns `true` if the seek was successful.
        #
        # @example Using a snapshot
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-sub"
        #
        #   snapshot = sub.create_snapshot
        #
        #   received_messages = sub.pull
        #   sub.acknowledge received_messages
        #
        #   sub.seek snapshot
        #
        # @example Using a time:
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-sub"
        #
        #   time = Time.now
        #
        #   received_messages = sub.pull
        #   sub.acknowledge received_messages
        #
        #   sub.seek time
        #
        def seek snapshot
          ensure_service!
          service.seek name, snapshot
          true
        end

        ##
        # Determines whether the subscription object was created without
        # retrieving the resource representation from the Pub/Sub service.
        #
        # @return [Boolean] `true` when the subscription was created without a
        #   resource representation, `false` otherwise.
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.get_subscription "my-topic-sub", skip_lookup: true
        #   sub.reference? #=> true
        #
        def reference?
          @grpc.nil?
        end

        ##
        # Determines whether the subscription object was created with a resource
        # representation from the Pub/Sub service.
        #
        # @return [Boolean] `true` when the subscription was created with a
        #   resource representation, `false` otherwise.
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.get_subscription "my-topic-sub"
        #   sub.resource? #=> true
        #
        def resource?
          !@grpc.nil?
        end

        ##
        # Reloads the subscription with current data from the Pub/Sub service.
        #
        # @return [Google::Cloud::PubSub::Subscription] Returns the reloaded
        #   subscription
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #
        #   sub = pubsub.get_subscription "my-topic-sub"
        #   sub.reload!
        #
        def reload!
          ensure_service!
          @grpc = service.get_subscription name
          @resource_name = nil
          self
        end
        alias refresh! reload!

        ##
        # Gets the [Cloud IAM](https://cloud.google.com/iam/) access control
        # policy for this subscription.
        #
        # @see https://cloud.google.com/pubsub/docs/reference/rpc/google.iam.v1#iampolicy
        #   google.iam.v1.IAMPolicy
        #
        # @yield [policy] A block for updating the policy. The latest policy
        #   will be read from the Pub/Sub service and passed to the block. After
        #   the block completes, the modified policy will be written to the
        #   service.
        # @yieldparam [Policy] policy the current Cloud IAM Policy for this
        #   subscription
        #
        # @return [Policy] the current Cloud IAM Policy for this subscription
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-subscription"
        #
        #   policy = sub.policy
        #
        # @example Update the policy by passing a block:
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-subscription"
        #
        #   sub.policy do |p|
        #     p.add "roles/owner", "user:owner@example.com"
        #   end
        #
        def policy
          ensure_service!
          grpc = service.get_subscription_policy name
          policy = Policy.from_grpc grpc
          return policy unless block_given?
          yield policy
          update_policy policy
        end

        ##
        # Updates the [Cloud IAM](https://cloud.google.com/iam/) access control
        # policy for this subscription. The policy should be read from
        # {#policy}. See {Google::Cloud::PubSub::Policy} for an explanation of
        # the policy `etag` property and how to modify policies.
        #
        # You can also update the policy by passing a block to {#policy}, which
        # will call this method internally after the block completes.
        #
        # @see https://cloud.google.com/pubsub/docs/reference/rpc/google.iam.v1#iampolicy
        #   google.iam.v1.IAMPolicy
        #
        # @param [Policy] new_policy a new or modified Cloud IAM Policy for this
        #   subscription
        #
        # @return [Policy] the policy returned by the API update operation
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-subscription"
        #
        #   policy = sub.policy # API call
        #
        #   policy.add "roles/owner", "user:owner@example.com"
        #
        #   sub.update_policy policy # API call
        #
        def update_policy new_policy
          ensure_service!
          grpc = service.set_subscription_policy name, new_policy.to_grpc
          Policy.from_grpc grpc
        end
        alias policy= update_policy

        ##
        # Tests the specified permissions against the [Cloud
        # IAM](https://cloud.google.com/iam/) access control policy.
        #
        # @see https://cloud.google.com/iam/docs/managing-policies Managing
        #   Policies
        #
        # @param [String, Array<String>] permissions The set of permissions to
        #   check access for. Permissions with wildcards (such as `*` or
        #   `storage.*`) are not allowed.
        #
        #   The permissions that can be checked on a subscription are:
        #
        #   * pubsub.subscriptions.consume
        #   * pubsub.subscriptions.get
        #   * pubsub.subscriptions.delete
        #   * pubsub.subscriptions.update
        #   * pubsub.subscriptions.getIamPolicy
        #   * pubsub.subscriptions.setIamPolicy
        #
        # @return [Array<String>] The permissions that have access.
        #
        # @example
        #   require "google/cloud/pubsub"
        #
        #   pubsub = Google::Cloud::PubSub.new
        #   sub = pubsub.subscription "my-subscription"
        #   perms = sub.test_permissions "pubsub.subscriptions.get",
        #                                "pubsub.subscriptions.consume"
        #   perms.include? "pubsub.subscriptions.get" #=> true
        #   perms.include? "pubsub.subscriptions.consume" #=> false
        #
        def test_permissions *permissions
          permissions = Array(permissions).flatten
          ensure_service!
          grpc = service.test_subscription_permissions name, permissions
          grpc.permissions
        end

        ##
        # @private
        # New Subscription from a Google::Cloud::PubSub::V1::Subscription
        # object.
        def self.from_grpc grpc, service
          new.tap do |f|
            f.grpc = grpc
            f.service = service
          end
        end

        ##
        # @private New reference {Subscription} object without making an HTTP
        # request.
        def self.from_name name, service, options = {}
          name = service.subscription_path name, options
          from_grpc(nil, service).tap do |s|
            s.instance_variable_set :@resource_name, name
          end
        end

        protected

        ##
        # @private Raise an error unless an active connection to the service is
        # available.
        def ensure_service!
          raise "Must have active connection to service" unless service
        end

        ##
        # Ensures a Google::Cloud::PubSub::V1::Subscription object exists.
        def ensure_grpc!
          ensure_service!
          reload! if reference?
        end

        ##
        # Makes sure the values are the `ack_id`. If given several
        # {ReceivedMessage} objects extract the `ack_id` values.
        def coerce_ack_ids messages
          Array(messages).flatten.map do |msg|
            msg.respond_to?(:ack_id) ? msg.ack_id : msg.to_s
          end
        end
      end
    end

    Pubsub = PubSub unless const_defined? :Pubsub
  end
end
