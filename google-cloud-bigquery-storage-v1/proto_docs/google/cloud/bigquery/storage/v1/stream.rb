# frozen_string_literal: true

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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Cloud
    module Bigquery
      module Storage
        module V1
          # Information about the ReadSession.
          # @!attribute [r] name
          #   @return [::String]
          #     Output only. Unique identifier for the session, in the form
          #     `projects/{project_id}/locations/{location}/sessions/{session_id}`.
          # @!attribute [r] expire_time
          #   @return [::Google::Protobuf::Timestamp]
          #     Output only. Time at which the session becomes invalid. After this time, subsequent
          #     requests to read this Session will return errors. The expire_time is
          #     automatically assigned and currently cannot be specified or updated.
          # @!attribute [rw] data_format
          #   @return [::Google::Cloud::Bigquery::Storage::V1::DataFormat]
          #     Immutable. Data format of the output data.
          # @!attribute [r] avro_schema
          #   @return [::Google::Cloud::Bigquery::Storage::V1::AvroSchema]
          #     Output only. Avro schema.
          # @!attribute [r] arrow_schema
          #   @return [::Google::Cloud::Bigquery::Storage::V1::ArrowSchema]
          #     Output only. Arrow schema.
          # @!attribute [rw] table
          #   @return [::String]
          #     Immutable. Table that this ReadSession is reading from, in the form
          #     `projects/{project_id}/datasets/{dataset_id}/tables/{table_id}`
          # @!attribute [rw] table_modifiers
          #   @return [::Google::Cloud::Bigquery::Storage::V1::ReadSession::TableModifiers]
          #     Optional. Any modifiers which are applied when reading from the specified table.
          # @!attribute [rw] read_options
          #   @return [::Google::Cloud::Bigquery::Storage::V1::ReadSession::TableReadOptions]
          #     Optional. Read options for this session (e.g. column selection, filters).
          # @!attribute [r] streams
          #   @return [::Array<::Google::Cloud::Bigquery::Storage::V1::ReadStream>]
          #     Output only. A list of streams created with the session.
          #
          #     At least one stream is created with the session. In the future, larger
          #     request_stream_count values *may* result in this list being unpopulated,
          #     in that case, the user will need to use a List method to get the streams
          #     instead, which is not yet available.
          class ReadSession
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods

            # Additional attributes when reading a table.
            # @!attribute [rw] snapshot_time
            #   @return [::Google::Protobuf::Timestamp]
            #     The snapshot time of the table. If not set, interpreted as now.
            class TableModifiers
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # Options dictating how we read a table.
            # @!attribute [rw] selected_fields
            #   @return [::Array<::String>]
            #     Names of the fields in the table that should be read. If empty, all
            #     fields will be read. If the specified field is a nested field, all
            #     the sub-fields in the field will be selected. The output field order is
            #     unrelated to the order of fields in selected_fields.
            # @!attribute [rw] row_restriction
            #   @return [::String]
            #     SQL text filtering statement, similar to a WHERE clause in a query.
            #     Aggregates are not supported.
            #
            #     Examples: "int_field > 5"
            #               "date_field = CAST('2014-9-27' as DATE)"
            #               "nullable_field is not NULL"
            #               "st_equals(geo_field, st_geofromtext("POINT(2, 2)"))"
            #               "numeric_field BETWEEN 1.0 AND 5.0"
            class TableReadOptions
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end
          end

          # Information about a single stream that gets data out of the storage system.
          # Most of the information about `ReadStream` instances is aggregated, making
          # `ReadStream` lightweight.
          # @!attribute [r] name
          #   @return [::String]
          #     Output only. Name of the stream, in the form
          #     `projects/{project_id}/locations/{location}/sessions/{session_id}/streams/{stream_id}`.
          class ReadStream
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # Data format for input or output data.
          module DataFormat
            DATA_FORMAT_UNSPECIFIED = 0

            # Avro is a standard open source row based file format.
            # See https://avro.apache.org/ for more details.
            AVRO = 1

            # Arrow is a standard open source column-based message format.
            # See https://arrow.apache.org/ for more details.
            ARROW = 2
          end
        end
      end
    end
  end
end
