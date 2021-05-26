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


require "delegate"

module Google
  module Cloud
    module Firestore
      class QueryPartition
        ##
        # QueryPartition::List is a special case Array with additional values.
        #
        # @example
        #   require "google/cloud/firestore"
        #
        #   firestore = Google::Cloud::Firestore.new
        #
        #   col_group = firestore.col_group "cities"
        #
        #   partitions = col_group.partitions 3
        #
        #   queries = partitions.map(&:create_query)
        #
        class List < DelegateClass(::Array)
          ##
          # If not empty, indicates that there are more records that match
          # the request and this value should be passed to continue.
          attr_accessor :token

          ##
          # @private Create a new QueryPartition::List with an array of
          # QueryPartition instances.
          def initialize arr = []
            super arr
          end

          ##
          # Whether there is a next page of query partitions.
          #
          # @return [Boolean]
          #
          # @example
          #   require "google/cloud/firestore"
          #
          #   firestore = Google::Cloud::Firestore.new
          #
          #   col_group = firestore.col_group "cities"
          #
          #   partitions = col_group.partitions 3
          #   if partitions.next?
          #     next_partitions = partitions.next
          #   end
          #
          def next?
            !token.nil?
          end

          ##
          # Retrieve the next page of query partitions.
          #
          # @return [QueryPartition::List]
          #
          # @example
          #   require "google/cloud/firestore"
          #
          #   firestore = Google::Cloud::Firestore.new
          #
          #   col_group = firestore.col_group "cities"
          #
          #   partitions = col_group.partitions 3
          #   if partitions.next?
          #     next_partitions = partitions.next
          #   end
          #
          def next
            return nil unless next?
            ensure_client!
            grpc = @client.service.partition_query @parent, @query.query, @partition_count, token: token, max: @max
            self.class.from_grpc grpc, @client, @parent, @query, @partition_count, max: @max, start_at: @start_at
          end

          ##
          # Retrieves remaining results by repeatedly invoking {#next} until
          # {#next?} returns `false`. Calls the given block once for each
          # result, which is passed as the argument to the block.
          #
          # An Enumerator is returned if no block is given.
          #
          # This method will make repeated API calls until all remaining results
          # are retrieved. (Unlike `#each`, for example, which merely iterates
          # over the results returned by a single API call.) Use with caution.
          #
          # @param [Integer] request_limit The upper limit of API requests to
          #   make to load all query partitions. Default is no limit.
          # @yield [partition] The block for accessing each partition.
          # @yieldparam [QueryPartition] partition The query partition object.
          #
          # @return [Enumerator]
          #
          # @example Iterating each query partition by passing a block or proc:
          #   require "google/cloud/firestore"
          #
          #   firestore = Google::Cloud::Firestore.new
          #
          #   col_group = firestore.col_group "cities"
          #
          #   partitions = col_group.partitions 3
          #
          #   queries = partitions.all(&:create_query)
          #
          # @example Using the enumerator by not passing a block:
          #   require "google/cloud/firestore"
          #
          #   firestore = Google::Cloud::Firestore.new
          #
          #   col_group = firestore.col_group "cities"
          #
          #   partitions = col_group.partitions 3
          #
          #   queries = partitions.all.map(&:create_query)
          #
          # @example Limit the number of API calls made by `#all`:
          #   require "google/cloud/firestore"
          #
          #   firestore = Google::Cloud::Firestore.new
          #
          #   col_group = firestore.col_group "cities"
          #
          #   partitions = col_group.partitions 3
          #
          #   queries = partitions.all(request_limit: 10, &:create_query)
          #
          def all request_limit: nil, &block
            request_limit = request_limit.to_i if request_limit
            unless block_given?
              return enum_for :all, request_limit: request_limit
            end
            results = self
            loop do
              results.each(&block)
              if request_limit
                request_limit -= 1
                break if request_limit.negative?
              end
              break unless results.next?
              results = results.next
            end
          end

          ##
          # @private New QueryPartition::List from a
          # Google::Cloud::Firestore::V1::PartitionQueryResponse object.
          def self.from_grpc grpc, client, parent, query, partition_count, max: nil, start_at: nil
            token = grpc.next_page_token
            token = nil if token == ""

            partitions = List.new(Array(grpc.partitions).map do |cursor|
              end_before = cursor.values.map do |value|
                Convert.value_to_raw value, client
              end
              partition = QueryPartition.new query, start_at, end_before
              start_at = end_before
              partition
            end)
            # Return an extra partition (with en empty endBefore cursor) at the end of the results.
            partitions << QueryPartition.new(query, start_at, nil) unless token
            partitions.instance_variable_set :@parent, parent
            partitions.instance_variable_set :@query, query
            partitions.instance_variable_set :@partition_count, partition_count
            partitions.instance_variable_set :@token, token
            partitions.instance_variable_set :@client, client
            partitions.instance_variable_set :@max, max
            partitions.instance_variable_set :@start_at, start_at
            partitions
          end

          protected

          ##
          # Raise an error unless an active client is available.
          def ensure_client!
            raise "Must have active connection" unless @client
          end
        end
      end
    end
  end
end
