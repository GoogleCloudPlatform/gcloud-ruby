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


require "google/cloud/firestore/v1"
require "google/cloud/firestore/query"
require "google/cloud/firestore/query_partition"

module Google
  module Cloud
    module Firestore
      ##
      # # CollectionGroup
      #
      # A collection group object is used for adding documents, getting
      # document references, and querying for documents (See {Query}).
      #
      # @example
      #   require "google/cloud/firestore"
      #
      #   firestore = Google::Cloud::Firestore.new
      #
      #   # Get a collection group
      #   cities_col = firestore.col "cities"
      #
      #   # Get and print all city documents
      #   cities_col.get do |city|
      #     puts "#{city.document_id} has #{city[:population]} residents."
      #   end
      #
      class CollectionGroup < Query
        ##
        # Retrieves a list of document references for the documents in this
        # collection.
        #
        # The document references returned may include references to "missing
        # documents", i.e. document locations that have no document present but
        # which contain subcollections with documents. Attempting to read such a
        # document reference (e.g. via {DocumentReference#get}) will return
        # a {DocumentSnapshot} whose `exists?` method returns false.
        #
        # @param [String] token A previously-returned page token representing
        #   part of the larger set of results to view.
        # @param [Integer] max Maximum number of results to return.
        #
        # @return [Array<DocumentReference>] An array of document references.
        #
        # @example
        #   require "google/cloud/firestore"
        #
        #   firestore = Google::Cloud::Firestore.new
        #
        #   col_group = firestore.col_group "cities"
        #
        #   partitions = col_group.partitions 3
        #   partitions.each do |partition|
        #     puts partition.create_query
        #   end
        #
        def partitions partition_count, token: nil, max: nil
          ensure_service!

          # Partition queries require explicit ordering by __name__.
          query_with_default_order = order("__name__").query
          # Since we are always returning an extra partition (with en empty endBefore cursor), we reduce the desired
          # partition count by one.
          partition_count -= 1

          grpc = service.partition_query parent_path, query_with_default_order, partition_count, token: token, max: max

          QueryPartition::List.from_grpc grpc, client, parent_path, query_with_default_order, partition_count, max: max
        end

        ##
        # @private New Collection group object from a path.
        def self.from_collection_id parent_path, collection_id, client
          query = Google::Cloud::Firestore::V1::StructuredQuery.new(
            from: [
              Google::Cloud::Firestore::V1::StructuredQuery::CollectionSelector.new(
                collection_id: collection_id,
                all_descendants: true
              )
            ]
          )
          CollectionGroup.new query, parent_path, client
        end
      end
    end
  end
end
