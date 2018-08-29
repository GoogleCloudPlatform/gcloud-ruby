# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/bigquery/datatransfer/v1/datatransfer.proto for package 'google.cloud.bigquery.datatransfer.v1'
# Original file comments:
# Copyright 2018 Google Inc.
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
#


require 'grpc'
require 'google/cloud/bigquery/data_transfer/v1/data_transfer_pb'

module Google
  module Cloud
    module Bigquery
      module DataTransfer
        module V1
          module DataTransferService
            # The Google BigQuery Data Transfer Service API enables BigQuery users to
            # configure the transfer of their data from other Google Products into BigQuery.
            # This service contains methods that are end user exposed. It backs up the
            # frontend.
            class Service

              include GRPC::GenericService

              self.marshal_class_method = :encode
              self.unmarshal_class_method = :decode
              self.service_name = 'google.cloud.bigquery.datatransfer.v1.DataTransferService'

              # Retrieves a supported data source and returns its settings,
              # which can be used for UI rendering.
              rpc :GetDataSource, GetDataSourceRequest, DataSource
              # Lists supported data sources and returns their settings,
              # which can be used for UI rendering.
              rpc :ListDataSources, ListDataSourcesRequest, ListDataSourcesResponse
              # Creates a new data transfer configuration.
              rpc :CreateTransferConfig, CreateTransferConfigRequest, TransferConfig
              # Updates a data transfer configuration.
              # All fields must be set, even if they are not updated.
              rpc :UpdateTransferConfig, UpdateTransferConfigRequest, TransferConfig
              # Deletes a data transfer configuration,
              # including any associated transfer runs and logs.
              rpc :DeleteTransferConfig, DeleteTransferConfigRequest, Google::Protobuf::Empty
              # Returns information about a data transfer config.
              rpc :GetTransferConfig, GetTransferConfigRequest, TransferConfig
              # Returns information about all data transfers in the project.
              rpc :ListTransferConfigs, ListTransferConfigsRequest, ListTransferConfigsResponse
              # Creates transfer runs for a time range [start_time, end_time].
              # For each date - or whatever granularity the data source supports - in the
              # range, one transfer run is created.
              # Note that runs are created per UTC time in the time range.
              rpc :ScheduleTransferRuns, ScheduleTransferRunsRequest, ScheduleTransferRunsResponse
              # Returns information about the particular transfer run.
              rpc :GetTransferRun, GetTransferRunRequest, TransferRun
              # Deletes the specified transfer run.
              rpc :DeleteTransferRun, DeleteTransferRunRequest, Google::Protobuf::Empty
              # Returns information about running and completed jobs.
              rpc :ListTransferRuns, ListTransferRunsRequest, ListTransferRunsResponse
              # Returns user facing log messages for the data transfer run.
              rpc :ListTransferLogs, ListTransferLogsRequest, ListTransferLogsResponse
              # Returns true if valid credentials exist for the given data source and
              # requesting user.
              # Some data sources doesn't support service account, so we need to talk to
              # them on behalf of the end user. This API just checks whether we have OAuth
              # token for the particular user, which is a pre-requisite before user can
              # create a transfer config.
              rpc :CheckValidCreds, CheckValidCredsRequest, CheckValidCredsResponse
            end

            Stub = Service.rpc_stub_class
          end
        end
      end
    end
  end
end
