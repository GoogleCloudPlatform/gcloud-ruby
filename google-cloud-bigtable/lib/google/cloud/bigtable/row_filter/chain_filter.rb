# frozen_string_literal: true

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Cloud
    module Bigtable
      module RowFilter
        # # ChainFilter
        #
        # A RowFilter that sends rows through several RowFilters in sequence.
        #
        # The elements of "filters" are chained together to process the input row:
        # in row -> f(0) -> intermediate row -> f(1) -> ... -> f(N) -> out row
        # The full chain is executed atomically.
        #
        # @example
        #
        #   chain = Google::Cloud::Bigtable::RowFilter.chain
        #   # Add filters to chain filter
        #   chain.key("user-*").label("users")
        #
        class ChainFilter
          # @private
          # Creates an instance of a chain filter.
          def initialize
            @grpc = Google::Bigtable::V2::RowFilter::Chain.new
          end

          # Adds a chain filter instance.
          #
          # A Chain RowFilter that sends rows through several RowFilters in sequence.
          #
          # The elements of "filters" are chained together to process the input row:
          # in row -> f(0) -> intermediate row -> f(1) -> ... -> f(N) -> out row
          # The full chain is executed atomically.
          #
          # @param filter [SimpleFilter, ChainFilter, InterleaveFilter, ConditionFilter]
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example Create a chain filter and add a chain filter.
          #
          #   chain_1 = Google::Cloud::Bigtable::RowFilter.chain
          #
          #   # Add filters to chain filter
          #   chain_1.key("user-*").cells_per_row(5)
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain
          #   filter.chain(chain_1)
          #
          #   # OR
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.chain(chain_1)
          #
          def chain filter
            unless filter.instance_of?(ChainFilter)
              raise RowFilterError, "Filter type must be ChainFilter"
            end
            add(filter)
          end

          # Add interleave filter.
          #
          # A RowFilter that sends each row to each of several component
          # RowFilters and interleaves the results.
          #
          # The elements of "filters" all process a copy of the input row, and the
          # results are pooled, sorted, and combined into a single output row.
          # If multiple cells are produced with the same column and timestamp,
          # they will all appear in the output row in an unspecified mutual order.
          # Consider the following example, with three filters:
          #
          #                                  input row
          #                                      |
          #            -----------------------------------------------------
          #            |                         |                         |
          #           f(0)                      f(1)                      f(2)
          #            |                         |                         |
          #     1: foo,bar,10,x             foo,bar,10,z              far,bar,7,a
          #     2: foo,blah,11,z            far,blah,5,x              far,blah,5,x
          #            |                         |                         |
          #            -----------------------------------------------------
          #                                      |
          #     1:                      foo,bar,10,z   # could have switched with #2
          #     2:                      foo,bar,10,x   # could have switched with #1
          #     3:                      foo,blah,11,z
          #     4:                      far,bar,7,a
          #     5:                      far,blah,5,x   # identical to #6
          #     6:                      far,blah,5,x   # identical to #5
          #
          # All interleaved filters are executed atomically.
          #
          # See {Google::Cloud::Bigtable::RowFilter::InterleaveFilter}
          #
          # @param filter [SimpleFilter, ChainFilter, InterleaveFilter, ConditionFilter]
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example Add interleave filter to chain filter
          #
          #   interleave = Google::Cloud::Bigtable::RowFilter.interleave
          #
          #   # Add filters to interleave filter
          #   interleave.key("user-*").cells_per_column(3)
          #
          #   chain = Google::Cloud::Bigtable::RowFilter.chain.interleave(interleave)
          #
          def interleave filter
            unless filter.instance_of?(InterleaveFilter)
              raise RowFilterError, "Filter type must be InterleaveFilter"
            end
            add(filter)
          end

          # Adds a condition filter instance.
          #
          # A RowFilter that evaluates one of two possible RowFilters, depending on
          # whether or not a predicate RowFilter outputs any cells from the input row.
          #
          # IMPORTANT NOTE: The predicate filter does not execute atomically with the
          # true and false filters, which may lead to inconsistent or unexpected
          # results. Additionally, condition filters have poor performance, especially
          # when filters are set for the false condition.
          #
          # Cannot be used within the `predicate_filter`, `true_filter`, or `false_filter`.
          #
          # @param filter [Google::Cloud::Bigtable::RowFilter::ConditionFilter]
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   predicate = Google::Cloud::Bigtable::RowFilter.key("user-*")
          #
          #   label = Google::Cloud::Bigtable::RowFilter.label("user")
          #   strip_value = Google::Cloud::Bigtable::RowFilter.strip_value
          #
          #   condition_filter = Google::Cloud::Bigtable::RowFilter.condition(predicate).on_match(label).otherwise(strip_value)
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.condition(condition_filter)
          #
          def condition filter
            unless filter.instance_of?(ConditionFilter)
              raise RowFilterError, "Filter type must be ConditionFilter"
            end
            add(filter)
          end

          # Adds a pass filter instance.
          #
          # Matches all cells, regardless of input. Functionally equivalent to
          # leaving `filter` unset, but included for completeness.
          #
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.pass
          #
          def pass
            add(RowFilter.pass)
          end

          # Adds a block-all filter instance.
          #
          # Does not match any cells, regardless of input. Useful for temporarily
          # disabling just part of a filter.
          #
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.block
          #
          def block
            add(RowFilter.block)
          end

          # Adds a sink filter instance.
          #
          # Outputs all cells directly to the output of the read rather than to any parent filter.
          #
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.sink
          #
          def sink
            add(RowFilter.sink)
          end

          # Adds a strip-value filter instance
          #
          # Replaces each cell's value with an empty string.
          #
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.strip_value
          #
          def strip_value
            add(RowFilter.strip_value)
          end

          # Adds a key filter instance to match keys using regular expression.
          #
          # Matches only cells from rows whose keys satisfy the given RE2 regex. In
          # other words, passes through the entire row when the key matches, and
          # otherwise produces an empty row.
          # Note that, since row keys can contain arbitrary bytes, the `\C` escape
          # sequence must be used if a true wildcard is desired. The `.` character
          # will not match the new line character `\n`, which may be present in a
          # binary key.
          #
          # For Regex syntax:
          # @see https://github.com/google/re2/wiki/Syntax
          #
          # @param regex [String] Regex to match row keys.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.key("user-*")
          #
          def key regex
            add(RowFilter.key(regex))
          end

          # Adds a sample probability filter instance.
          #
          # Matches all cells from a row with probability p, and matches no cells
          # from the row with probability 1-p.
          #
          # @param probability [Float] Probability value
          #   Probability must be greather then 0 and less then 1.0.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.sample(0.5)
          #
          def sample probability
            add(RowFilter.sample(probability))
          end

          # Adds a family name match filter using a regular expression.
          #
          # Matches only cells from columns whose families satisfy the given RE2
          # regex. For technical reasons, the regex must not contain the `:`
          # character, even if it is not being used as a literal.
          # Note that, since column families cannot contain the new line character
          # `\n`, it is sufficient to use `.` as a full wildcard when matching
          # column family names.
          #
          # For Regex syntax:
          # @see https://github.com/google/re2/wiki/Syntax
          #
          # @param regex [String] Regex to match family name.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.family("cf-*")
          #
          def family regex
            add(RowFilter.family(regex))
          end

          # Add a column qualifier match filter using a regular expression
          #
          # Matches only cells from columns whose qualifiers satisfy the given RE2
          # regex.
          # Note that, since column qualifiers can contain arbitrary bytes, the `\C`
          # escape sequence must be used if a true wildcard is desired. The `.`
          # character will not match the new line character `\n`, which may be
          # present in a binary qualifier.
          #
          # For Regex syntax:
          # @see https://github.com/google/re2/wiki/Syntax
          #
          # @param regex [String] Regex to match column qualifier name.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.qualifier("user-name*")
          #
          def qualifier regex
            add(RowFilter.qualifier(regex))
          end

          # Adds a value match filter using a regular expression
          #
          # Matches only cells with values that satisfy the given regular expression.
          # Note that, since cell values can contain arbitrary bytes, the `\C` escape
          # sequence must be used if a true wildcard is desired. The `.` character
          # will not match the new line character `\n`, which may be present in a
          # binary value.
          #
          # For Regex syntax:
          # @see https://github.com/google/re2/wiki/Syntax
          #
          # @param regex [String] Regex to match cell value.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.value("abc*")
          #
          def value regex
            add(RowFilter.value(regex))
          end

          # Adds a label filter instance to apply a label based on the result of read rows.
          #
          # Applies the given label to all cells in the output row. This allows
          # the client to determine which results were produced from which part of
          # the filter.
          #
          # Values must be at most 15 characters and match the RE2
          # pattern `[a-z0-9\\-]+`
          #
          # Due to a technical limitation, it is not possible to apply
          # multiple labels to a cell. As a result, a chain may have no more than
          # one sub-filter that contains an `apply_label_transformer`. It is okay for
          # an Interleave to contain multiple `apply_label_transformers`, as they
          # will be applied to separate copies of the input.
          #
          # @param value [String] Label name
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.label("user-detail")
          #
          def label value
            add(RowFilter.label(value))
          end

          # Adds a cell per row offset filter instance to skip first N cells.
          #
          # Skips the first N cells of each row, matching all subsequent cells.
          # If duplicate cells are present, as is possible when using an Interleave,
          # each copy of the cell is counted separately.
          #
          # @param offset [Integer] Offset value.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.cells_per_row_offset(3)
          #
          def cells_per_row_offset offset
            add(RowFilter.cells_per_row_offset(offset))
          end

          # Adds a cells per row limit filter instance
          #
          # Matches only the first N cells of each row.
          # If duplicate cells are present, as is possible when using an Interleave,
          # each copy of the cell is counted separately.
          #
          # @param limit [String] Max cell match per row limit
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.cells_per_row(5)
          #
          def cells_per_row limit
            add(RowFilter.cells_per_row(limit))
          end

          # Adds a cells per column filter instance
          #
          # Matches only the most recent N cells within each column. For example,
          # if N=2, this filter would match column `foo:bar` at timestamps 10 and 9,
          # skip all earlier cells in `foo:bar`, and then begin matching again in
          # column `foo:bar2`.
          # If duplicate cells are present, as is possible when using an Interleave,
          # each copy of the cell is counted separately.
          #
          # @param limit [String] Max cell match per column limit
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.cells_per_column(5)
          #
          def cells_per_column limit
            add(RowFilter.cells_per_column(limit))
          end

          # Adds a timestamp range filter instance
          #
          # Matches only cells with timestamps within the given range.
          # Specifies a contiguous range of timestamps.
          #
          # @param from [Integer] Inclusive lower bound.
          #   If left empty, interpreted as 0.
          # @param to [Integer] Exclusive upper bound.
          #   If left empty, interpreted as infinity.
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   from = (Time.now - 300).to_i * 1000 # 300 seconds ago
          #   to = Time.now.to_f * 1000
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.timestamp_range(from: from, to: to)
          #
          def timestamp_range from: nil, to: nil
            add(RowFilter.timestamp_range(from: from, to: to))
          end

          # Adds a value range filter instance
          #
          # Matches only cells with values that fall within the given range.
          #
          # See {Google::Cloud::Bigtable::ValueRange#from} and { Google::Cloud::Bigtable::ValueRange#to} for range
          # option inclusive/exclusive options
          #
          # * The value at which to start the range. If neither field is set, interpreted as an empty string, inclusive.
          # * The value at which to end the range. If neither field is set, interpreted as the infinite string, exclusive.
          #
          # @param range [Google::Cloud::Bigtable::ValueRange]
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example Start to end range
          #
          #   range = Google::Cloud::Bigtable::ValueRange.from("abc").to('xyz')
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.value_range(range)
          #
          # @example Start exlusive to infinite end range
          #
          #   range = Google::Cloud::Bigtable::ValueRange.from("abc", inclusive: false)
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.value_range(range)
          #
          def value_range range
            add(RowFilter.value_range(range))
          end

          # Adds a column-range filter instance.
          #
          # Matches only cells from columns within the given range.
          #
          # @param range [Google::Cloud::Bigtable::ColumnRange]
          # @return [Google::Cloud::Bigtable::RowFilter::ChainFilter]
          #   `self` instance of chain filter.
          #
          # @example
          #
          #   range = Google::Cloud::Bigtable::ColumnRange.new(cf).from("field0").to('field5')
          #
          #   filter = Google::Cloud::Bigtable::RowFilter.chain.column_range(range)
          #
          def column_range range
            add(RowFilter.column_range(range))
          end

          # Gets number of filter count in chain filters.
          #
          # @return [Integer]
          #
          # @example
          #
          #  filter = Google::Cloud::Bigtable::RowFilter.chain.key("user-1*").label("user")
          #  filter.length # 2
          #
          def length
            @grpc.filters.length
          end

          # Gets a list of filters.
          #
          # @return [Array<Google::Bigtable::V2::RowFilter>]
          #
          def filters
            @grpc.filters
          end

          # @private
          #
          # Gets an gRPC object of RowFilter with a chain filter.
          #
          # @return [Google::Bigtable::V2::RowFilter]
          #
          def to_grpc
            Google::Bigtable::V2::RowFilter.new(chain: @grpc)
          end


          private

          # @private
          # Adds a filter to a chain.
          #
          # @param filter [SimpleFilter, ChainFilter, InterleaveFilter, ConditionFilter]
          #
          def add filter
            @grpc.filters << filter.to_grpc
            self
          end
        end
      end
    end
  end
end
