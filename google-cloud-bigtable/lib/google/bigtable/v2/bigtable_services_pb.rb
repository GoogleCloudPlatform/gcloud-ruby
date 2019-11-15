# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/bigtable/v2/bigtable.proto for package 'google.bigtable.v2'
# Original file comments:
# Copyright 2019 Google LLC.
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
require 'google/bigtable/v2/bigtable_pb'

module Google
  module Bigtable
    module V2
      module Bigtable
        # Service for reading from and writing to existing Bigtable tables.
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'google.bigtable.v2.Bigtable'

          # Streams back the contents of all requested rows in key order, optionally
          # applying the same Reader filter to each. Depending on their size,
          # rows and cells may be broken up across multiple responses, but
          # atomicity of each row will still be preserved. See the
          # ReadRowsResponse documentation for details.
          rpc :ReadRows, ReadRowsRequest, stream(ReadRowsResponse)
          # Returns a sample of row keys in the table. The returned row keys will
          # delimit contiguous sections of the table of approximately equal size,
          # which can be used to break up the data for distributed tasks like
          # mapreduces.
          rpc :SampleRowKeys, SampleRowKeysRequest, stream(SampleRowKeysResponse)
          # Mutates a row atomically. Cells already present in the row are left
          # unchanged unless explicitly changed by `mutation`.
          rpc :MutateRow, MutateRowRequest, MutateRowResponse
          # Mutates multiple rows in a batch. Each individual row is mutated
          # atomically as in MutateRow, but the entire batch is not executed
          # atomically.
          rpc :MutateRows, MutateRowsRequest, stream(MutateRowsResponse)
          # Mutates a row atomically based on the output of a predicate Reader filter.
          rpc :CheckAndMutateRow, CheckAndMutateRowRequest, CheckAndMutateRowResponse
          # Modifies a row atomically on the server. The method reads the latest
          # existing timestamp and value from the specified columns and writes a new
          # entry based on pre-defined read/modify/write rules. The new value for the
          # timestamp is the greater of the existing timestamp or the current server
          # time. The method returns the new contents of all modified cells.
          rpc :ReadModifyWriteRow, ReadModifyWriteRowRequest, ReadModifyWriteRowResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
