# Copyright 2016 Google Inc. All rights reserved.
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


require "gcloud/datastore/credentials"
require "google/datastore/v1beta3/datastore_services"
require "gcloud/backoff"

module Gcloud
  module Datastore
    ##
    # @private Represents the gRPC Datastore service, including all the API
    # methods.
    class Service
      DEFAULT_HOST = "datastore.googleapis.com"
      attr_accessor :project, :credentials

      ##
      # Creates a new Service instance.
      def initialize project, credentials
        @project = project
        @credentials = credentials
      end

      def creds
        GRPC::Core::ChannelCredentials.new.compose \
          GRPC::Core::CallCredentials.new credentials.client.updater_proc
      end

      ##
      # The Datastore API URL.
      def host
        @host || ENV["DATASTORE_HOST"] || DEFAULT_HOST
      end

      ##
      # Update the Datastore API URL.
      def host= new_host
        @datastore = nil # Reset the GRPC object when host is set
        @host = new_host
      end

      def datastore
        return mocked_datastore if mocked_datastore
        @datastore ||= Google::Datastore::V1beta3::Datastore::Stub.new(
          host, creds)
      end
      attr_accessor :mocked_datastore

      ##
      # Allocate IDs for incomplete keys.
      # (This is useful for referencing an entity before it is inserted.)
      def allocate_ids *incomplete_keys
        allocate_req = Google::Datastore::V1beta3::AllocateIdsRequest.new(
          project_id: project,
          keys: incomplete_keys
        )

        backoff { datastore.allocate_ids allocate_req }
      end

      ##
      # Look up entities by keys.
      def lookup *keys
        lookup_req = Google::Datastore::V1beta3::LookupRequest.new(
          project_id: project,
          keys: keys
        )

        backoff { datastore.lookup lookup_req }
      end

      # Query for entities.
      def run_query query, namespace = nil
        run_req = Google::Datastore::V1beta3::RunQueryRequest.new(
          project_id: project)
        if query.is_a? Google::Datastore::V1beta3::Query
          run_req["query"] = query
        elsif query.is_a? Google::Datastore::V1beta3::GqlQuery
          run_req["gql_query"] = query
        else
          fail ArgumentError, "Unable to query with a #{query.class} object."
        end

        run_req.partition_id = Google::Datastore::V1beta3::PartitionId.new(
          project_id: project,
          namespace_id: namespace
        ) if namespace

        backoff { datastore.run_query run_req }
      end

      ##
      # Begin a new transaction.
      def begin_transaction
        tx_req = Google::Datastore::V1beta3::BeginTransactionRequest.new(
          project_id: project
        )

        backoff { datastore.begin_transaction tx_req }
      end

      ##
      # Commit a transaction, optionally creating, deleting or modifying
      # some entities.
      def commit mutations, transaction: nil
        commit_req = Google::Datastore::V1beta3::CommitRequest.new(
          project_id: project,
          mode: :NON_TRANSACTIONAL,
          mutations: mutations
        )
        if transaction
          commit_req.mode = :TRANSACTIONAL
          commit_req.transaction = transaction
        end

        backoff { datastore.commit commit_req }
      end

      ##
      # Roll back a transaction.
      def rollback transaction
        rb_req = Google::Datastore::V1beta3::RollbackRequest.new(
          project_id: project,
          transaction: transaction
        )

        backoff { datastore.rollback rb_req }
      end

      def inspect
        "#{self.class}(#{@dataset_id})"
      end

      def backoff options = {}
        Gcloud::Backoff.new(options).execute_grpc do
          yield
        end
      end
    end
  end
end
