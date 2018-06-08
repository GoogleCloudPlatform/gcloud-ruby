# Copyright 2018 Google LLC
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


module Google
  module Cloud
    module Bigtable
      class Table
        # # Job
        #
        # A resource representing the long-running, asynchronous processing of
        # an instance create or update operation. The job can be refreshed to
        # retrieve the table object once the operation has been completed.
        #
        # See {Table#create_snapshot}.
        #
        # @see https://cloud.google.com/bigtable/docs/reference/admin/rpc/google.longrunning#google.longrunning.Operation
        #   Long-running Operation
        #
        # @example
        #   require "google/cloud/bigtable"
        #
        #   bigtable = Google::Cloud::Bigtable.new
        #
        #   instance = bigtable.instance("my-instance")
        #   table = instance.table("my-table")
        #   snapshot = table.snapshot("my-table-snapshot")
        #
        #   job = snapshot.create_table(
        #     "new-my-table",
        #     "my-cluster",
        #     "my-table-snapshot"
        #   )
        #
        #   job.done? #=> false
        #   job.reload! # API call
        #   job.done? #=> true
        #
        #   if job.error?
        #     status = job.error
        #   else
        #     table = job.table
        #   end
        #
        class Job
          # @private
          # The Google::Gax::Operation gRPC object.
          attr_accessor :grpc

          # @private
          # The gRPC Service object.
          attr_accessor :service

          # The instance that is the object of the operation.
          #
          # @return [Google::Cloud::Bigtable::Table, nil] The table instance, or
          #   `nil` if the operation is not complete.
          #
          # @example
          #   require "google/cloud/bigtable"
          #
          #   bigtable = Google::Cloud::Bigtable.new
          #
          #   instance = bigtable.instance("my-instance")
          #   table = instance.table("my-table")
          #   snapshot = table.snapshot("my-table-snapshot")
          #
          #   job = snapshot.create_table(
          #     "new-my-table",
          #     "my-cluster",
          #     "my-table-snapshot"
          #   )
          #
          #   job.done? #=> false
          #   job.reload!
          #   job.done? #=> true
          #   table = job.table
          #
          def table
            return nil unless done?
            return nil unless @grpc.grpc_op.result == :response
            Table.from_grpc(@grpc.results, service)
          end

          ##
          # Checks if the processing of the instance operation is complete.
          #
          # @return [boolean] `true` when complete, `false` otherwise.
          #
          # @example
          #   require "google/cloud/bigtable"
          #
          #   bigtable = Google::Cloud::Bigtable.new
          #
          #   instance = bigtable.instance("my-instance")
          #   table = instance.table("my-table")
          #   snapshot = table.snapshot("my-table-snapshot")
          #
          #   job = snapshot.create_table(
          #     "new-my-table",
          #     "my-cluster",
          #     "my-table-snapshot"
          #   )
          #
          #   job.done? #=> false
          #
          def done?
            @grpc.done?
          end

          ##
          # Checks if the processing of the instance operation has errored.
          #
          # @return [boolean] `true` when errored, `false` otherwise.
          #
          # @example
          #   require "google/cloud/bigtable"
          #
          #   bigtable = Google::Cloud::Bigtable.new
          #
          #   instance = bigtable.instance("my-instance")
          #   table = instance.table("my-table")
          #   snapshot = table.snapshot("my-table-snapshot")
          #
          #   job = snapshot.create_table(
          #     "new-my-table",
          #     "my-cluster",
          #     "my-table-snapshot"
          #   )
          #
          #   job.error? #=> false
          #
          def error?
            @grpc.error?
          end

          ##
          # The status if the operation associated with this job produced an
          # error.
          #
          # @return [Object, Google::Rpc::Status, nil] A status object with
          #   the status code and message, or `nil` if no error occurred.
          #
          # @example
          #   require "google/cloud/bigtable"
          #
          #   bigtable = Google::Cloud::Bigtable.new
          #
          #   instance = bigtable.instance("my-instance")
          #   table = instance.table("my-table")
          #   snapshot = table.snapshot("my-table-snapshot")
          #
          #   job = snapshot.create_table(
          #     "new-my-table",
          #     "my-cluster",
          #     "my-table-snapshot"
          #   )
          #
          #   job.error? # true
          #
          #   error = job.error
          #
          def error
            return nil unless error?
            @grpc.error
          end

          # Reloads the job with current data from the long-running,
          # asynchronous processing of an instance operation.
          #
          # @return [Google::Cloud::Bigtable::Table::Job] The same job
          #   instance.
          #
          # @example
          #   require "google/cloud/bigtable"
          #
          #   bigtable = Google::Cloud::Bigtable.new
          #
          #   instance = bigtable.instance("my-instance")
          #   table = instance.table("my-table")
          #   snapshot = table.snapshot("my-table-snapshot")
          #
          #   job = snapshot.create_table(
          #     "new-my-table",
          #     "my-cluster",
          #     "my-table-snapshot"
          #   )
          #
          #   job.done? #=> false
          #   job.reload! # API call
          #   job.done? #=> true
          #
          def reload!
            @grpc.reload!
            self
          end

          # Reloads the job until the operation is complete. The delay between
          # reloads will incrementally increase.
          #
          # @example
          #   require "google/cloud/bigtable"
          #
          #   bigtable = Google::Cloud::Bigtable.new
          #
          #   instance = bigtable.instance("my-instance")
          #   table = instance.table("my-table")
          #   snapshot = table.snapshot("my-table-snapshot")
          #
          #   job = snapshot.create_table(
          #     "new-my-table",
          #     "my-cluster",
          #     "my-table-snapshot"
          #   )
          #
          #   job.done? #=> false
          #   job.wait_until_done!
          #   job.done? #=> true
          #
          def wait_until_done!
            @grpc.wait_until_done!
          end

          # @private
          # New Table::Job from a Google::Gax::Operation object.
          def self.from_grpc grpc, service
            new.tap do |job|
              job.grpc =  grpc
              job.service = service
            end
          end
        end
      end
    end
  end
end
