# Copyright 2020 Google LLC
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
  module Spanner
    module V1
      # Results from {Google::Spanner::V1::Spanner::Read Read} or
      # {Google::Spanner::V1::Spanner::ExecuteSql ExecuteSql}.
      # @!attribute [rw] metadata
      #   @return [Google::Spanner::V1::ResultSetMetadata]
      #     Metadata about the result set, such as row type information.
      # @!attribute [rw] rows
      #   @return [Array<Google::Protobuf::ListValue>]
      #     Each element in `rows` is a row whose format is defined by
      #     {Google::Spanner::V1::ResultSetMetadata#row_type metadata::row_type}. The ith element
      #     in each row matches the ith field in
      #     {Google::Spanner::V1::ResultSetMetadata#row_type metadata::row_type}. Elements are
      #     encoded based on type as described
      #     {Google::Spanner::V1::TypeCode here}.
      # @!attribute [rw] stats
      #   @return [Google::Spanner::V1::ResultSetStats]
      #     Query plan and execution statistics for the SQL statement that
      #     produced this result set. These can be requested by setting
      #     {Google::Spanner::V1::ExecuteSqlRequest#query_mode ExecuteSqlRequest#query_mode}.
      #     DML statements always produce stats containing the number of rows
      #     modified, unless executed using the
      #     {Google::Spanner::V1::ExecuteSqlRequest::QueryMode::PLAN ExecuteSqlRequest::QueryMode::PLAN} {Google::Spanner::V1::ExecuteSqlRequest#query_mode ExecuteSqlRequest#query_mode}.
      #     Other fields may or may not be populated, based on the
      #     {Google::Spanner::V1::ExecuteSqlRequest#query_mode ExecuteSqlRequest#query_mode}.
      class ResultSet; end

      # Partial results from a streaming read or SQL query. Streaming reads and
      # SQL queries better tolerate large result sets, large rows, and large
      # values, but are a little trickier to consume.
      # @!attribute [rw] metadata
      #   @return [Google::Spanner::V1::ResultSetMetadata]
      #     Metadata about the result set, such as row type information.
      #     Only present in the first response.
      # @!attribute [rw] values
      #   @return [Array<Google::Protobuf::Value>]
      #     A streamed result set consists of a stream of values, which might
      #     be split into many `PartialResultSet` messages to accommodate
      #     large rows and/or large values. Every N complete values defines a
      #     row, where N is equal to the number of entries in
      #     {Google::Spanner::V1::StructType#fields metadata::row_type::fields}.
      #
      #     Most values are encoded based on type as described
      #     {Google::Spanner::V1::TypeCode here}.
      #
      #     It is possible that the last value in values is "chunked",
      #     meaning that the rest of the value is sent in subsequent
      #     `PartialResultSet`(s). This is denoted by the {Google::Spanner::V1::PartialResultSet#chunked_value chunked_value}
      #     field. Two or more chunked values can be merged to form a
      #     complete value as follows:
      #
      #     * `bool/number/null`: cannot be chunked
      #       * `string`: concatenate the strings
      #       * `list`: concatenate the lists. If the last element in a list is a
      #         `string`, `list`, or `object`, merge it with the first element in
      #         the next list by applying these rules recursively.
      #       * `object`: concatenate the (field name, field value) pairs. If a
      #         field name is duplicated, then apply these rules recursively
      #         to merge the field values.
      #
      #       Some examples of merging:
      #
      #       = Strings are concatenated.
      #       "foo", "bar" => "foobar"
      #
      #       = Lists of non-strings are concatenated.
      #       [2, 3], [4] => [2, 3, 4]
      #
      #       = Lists are concatenated, but the last and first elements are merged
      #       = because they are strings.
      #       ["a", "b"], ["c", "d"] => ["a", "bc", "d"]
      #
      #       = Lists are concatenated, but the last and first elements are merged
      #       = because they are lists. Recursively, the last and first elements
      #       = of the inner lists are merged because they are strings.
      #       ["a", ["b", "c"]], [["d"], "e"] => ["a", ["b", "cd"], "e"]
      #
      #       = Non-overlapping object fields are combined.
      #       {"a": "1"}, {"b": "2"} => {"a": "1", "b": 2"}
      #
      #       = Overlapping object fields are merged.
      #       {"a": "1"}, {"a": "2"} => {"a": "12"}
      #
      #       = Examples of merging objects containing lists of strings.
      #       {"a": ["1"]}, {"a": ["2"]} => {"a": ["12"]}
      #
      #     For a more complete example, suppose a streaming SQL query is
      #     yielding a result set whose rows contain a single string
      #     field. The following `PartialResultSet`s might be yielded:
      #
      #         {
      #           "metadata": { ... }
      #           "values": ["Hello", "W"]
      #           "chunked_value": true
      #           "resume_token": "Af65..."
      #         }
      #         {
      #           "values": ["orl"]
      #           "chunked_value": true
      #           "resume_token": "Bqp2..."
      #         }
      #         {
      #           "values": ["d"]
      #           "resume_token": "Zx1B..."
      #         }
      #
      #     This sequence of `PartialResultSet`s encodes two rows, one
      #     containing the field value `"Hello"`, and a second containing the
      #     field value `"World" = "W" + "orl" + "d"`.
      # @!attribute [rw] chunked_value
      #   @return [true, false]
      #     If true, then the final value in {Google::Spanner::V1::PartialResultSet#values values} is chunked, and must
      #     be combined with more values from subsequent `PartialResultSet`s
      #     to obtain a complete field value.
      # @!attribute [rw] resume_token
      #   @return [String]
      #     Streaming calls might be interrupted for a variety of reasons, such
      #     as TCP connection loss. If this occurs, the stream of results can
      #     be resumed by re-sending the original request and including
      #     `resume_token`. Note that executing any other transaction in the
      #     same session invalidates the token.
      # @!attribute [rw] stats
      #   @return [Google::Spanner::V1::ResultSetStats]
      #     Query plan and execution statistics for the statement that produced this
      #     streaming result set. These can be requested by setting
      #     {Google::Spanner::V1::ExecuteSqlRequest#query_mode ExecuteSqlRequest#query_mode} and are sent
      #     only once with the last response in the stream.
      #     This field will also be present in the last response for DML
      #     statements.
      class PartialResultSet; end

      # Metadata about a {Google::Spanner::V1::ResultSet ResultSet} or {Google::Spanner::V1::PartialResultSet PartialResultSet}.
      # @!attribute [rw] row_type
      #   @return [Google::Spanner::V1::StructType]
      #     Indicates the field names and types for the rows in the result
      #     set.  For example, a SQL query like `"SELECT UserId, UserName FROM
      #     Users"` could return a `row_type` value like:
      #
      #         "fields": [
      #           { "name": "UserId", "type": { "code": "INT64" } },
      #           { "name": "UserName", "type": { "code": "STRING" } },
      #         ]
      # @!attribute [rw] transaction
      #   @return [Google::Spanner::V1::Transaction]
      #     If the read or SQL query began a transaction as a side-effect, the
      #     information about the new transaction is yielded here.
      class ResultSetMetadata; end

      # Additional statistics about a {Google::Spanner::V1::ResultSet ResultSet} or {Google::Spanner::V1::PartialResultSet PartialResultSet}.
      # @!attribute [rw] query_plan
      #   @return [Google::Spanner::V1::QueryPlan]
      #     {Google::Spanner::V1::QueryPlan QueryPlan} for the query associated with this result.
      # @!attribute [rw] query_stats
      #   @return [Google::Protobuf::Struct]
      #     Aggregated statistics from the execution of the query. Only present when
      #     the query is profiled. For example, a query could return the statistics as
      #     follows:
      #
      #         {
      #           "rows_returned": "3",
      #           "elapsed_time": "1.22 secs",
      #           "cpu_time": "1.19 secs"
      #         }
      # @!attribute [rw] row_count_exact
      #   @return [Integer]
      #     Standard DML returns an exact count of rows that were modified.
      # @!attribute [rw] row_count_lower_bound
      #   @return [Integer]
      #     Partitioned DML does not offer exactly-once semantics, so it
      #     returns a lower bound of the rows modified.
      class ResultSetStats; end
    end
  end
end