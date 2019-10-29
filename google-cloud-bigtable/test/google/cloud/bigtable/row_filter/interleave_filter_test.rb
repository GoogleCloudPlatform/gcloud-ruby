# frozen_string_literal: true

# Copyright 2019 Google LLC
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


require "helper"

describe Google::Cloud::Bigtable::RowFilter::InterleaveFilter, :mock_bigtable do
  let(:table) do
    Google::Cloud::Bigtable::DataClient::Table.new(
      Object.new, "dummy-table-path"
    )
  end
  let(:interleave_filter) { Google::Cloud::Bigtable::RowFilter.interleave }

  it "knows its attributes" do
    interleave_filter.must_be_kind_of Google::Cloud::Bigtable::RowFilter::InterleaveFilter
    filters = interleave_filter.filters
    filters.must_be_kind_of Array
    filters.must_be :frozen?
    filters.must_be :empty?
  end

  it "creates a sink filter" do
    interleave_filter.filters.must_be :empty?
    interleave_filter.sink
    assert_filter :sink
  end

  it "creates a pass filter" do
    interleave_filter.filters.must_be :empty?
    interleave_filter.pass
    assert_filter :pass_all_filter
  end

  it "creates a block filter" do
    interleave_filter.filters.must_be :empty?
    interleave_filter.block
    assert_filter :block_all_filter
  end

  it "creates a strip_value filter" do
    interleave_filter.filters.must_be :empty?
    interleave_filter.strip_value
    assert_filter :strip_value_transformer
  end

  it "creates a key filter" do
    regex = "user-*"
    interleave_filter.filters.must_be :empty?
    interleave_filter.key(regex)
    filter = assert_filter :row_key_regex_filter
    filter.to_grpc.row_key_regex_filter.must_equal regex
  end

  it "creates a family filter" do
    regex = "cf-*"
    interleave_filter.filters.must_be :empty?
    interleave_filter.family(regex)
    filter = assert_filter :family_name_regex_filter
    filter.to_grpc.family_name_regex_filter.must_equal regex
  end

  it "creates a qualifier filter" do
    regex = "field*"
    interleave_filter.filters.must_be :empty?
    interleave_filter.qualifier(regex)
    filter = assert_filter :column_qualifier_regex_filter
    filter.to_grpc.column_qualifier_regex_filter.must_equal regex
  end

  it "creates a value filter" do
    regex = "abc*"
    interleave_filter.filters.must_be :empty?
    interleave_filter.value(regex)
    filter = assert_filter :value_regex_filter
    filter.to_grpc.value_regex_filter.must_equal regex
  end

  it "creates a label filter" do
    label = "test"
    interleave_filter.filters.must_be :empty?
    interleave_filter.label(label)
    filter = assert_filter :apply_label_transformer
    filter.to_grpc.apply_label_transformer.must_equal label
  end

  it "creates a cells_per_row_offset filter" do
    offset = 5
    interleave_filter.filters.must_be :empty?
    interleave_filter.cells_per_row_offset(offset)
    filter = assert_filter :cells_per_row_offset_filter
    filter.to_grpc.cells_per_row_offset_filter.must_equal offset
  end

  it "creates a cells_per_row filter" do
    limit = 10
    interleave_filter.filters.must_be :empty?
    interleave_filter.cells_per_row(limit)
    filter = assert_filter :cells_per_row_limit_filter
    filter.to_grpc.cells_per_row_limit_filter.must_equal limit
  end

  it "creates a cells_per_column filter" do
    limit = 10
    interleave_filter.filters.must_be :empty?
    interleave_filter.cells_per_column(limit)
    filter = assert_filter :cells_per_column_limit_filter
    filter.to_grpc.cells_per_column_limit_filter.must_equal limit
  end

  describe "timestamp_range" do
    it "creates a timestamp_range filter" do
      from = timestamp_micros - 3000000
      to = timestamp_micros
      interleave_filter.filters.must_be :empty?
      interleave_filter.timestamp_range(from: from, to: to)
      filter = assert_filter :timestamp_range_filter
      range_grpc = Google::Bigtable::V2::TimestampRange.new(
        start_timestamp_micros: from, end_timestamp_micros: to
      )
      filter.to_grpc.timestamp_range_filter.must_equal range_grpc
    end

    it "creates a timestamp_range filter with only from range" do
      from = timestamp_micros - 3000000
      interleave_filter.filters.must_be :empty?
      interleave_filter.timestamp_range(from: from)
      filter = assert_filter :timestamp_range_filter
      range_grpc = Google::Bigtable::V2::TimestampRange.new(
        start_timestamp_micros: from
      )
      filter.to_grpc.timestamp_range_filter.must_equal range_grpc
    end

    it "creates a timestamp_range filter with only to range" do
      to = timestamp_micros
      interleave_filter.filters.must_be :empty?
      interleave_filter.timestamp_range(to: to)
      filter = assert_filter :timestamp_range_filter
      range_grpc = Google::Bigtable::V2::TimestampRange.new(
        end_timestamp_micros: to
      )
      filter.to_grpc.timestamp_range_filter.must_equal range_grpc
    end
  end

  describe "#value_range" do
    it "creates a value_range filter" do
      from_value = "abc"
      to_value = "xyz"
      range = Google::Cloud::Bigtable::ValueRange.new.from(from_value).to(to_value)
      interleave_filter.filters.must_be :empty?
      interleave_filter.value_range(range)
      filter = assert_filter :value_range_filter
      grpc = filter.to_grpc.value_range_filter
      grpc.must_be_kind_of Google::Bigtable::V2::ValueRange
      grpc.start_value_closed.must_equal from_value
      grpc.end_value_open.must_equal to_value
    end

    it "range instance must be type of ValueRange" do
      proc {
        interleave_filter.value_range(Object.new)
      }.must_raise Google::Cloud::Bigtable::RowFilterError
    end
  end

  describe "#column_range" do
    it "creates a column_range filter" do
      family = "cf"
      from_value = "field0"
      to_value = "field5"

      range = Google::Cloud::Bigtable::ColumnRange.new(family).from(from_value).to(to_value)
      interleave_filter.filters.must_be :empty?
      interleave_filter.column_range(range)
      filter = assert_filter :column_range_filter
      grpc = filter.to_grpc.column_range_filter
      grpc.must_be_kind_of Google::Bigtable::V2::ColumnRange
      grpc.family_name.must_equal family
      grpc.start_qualifier_closed.must_equal from_value
      grpc.end_qualifier_open.must_equal to_value
    end

    it "range instance must be type of ColumnRange" do
      proc {
        interleave_filter.column_range(Object.new)
      }.must_raise Google::Cloud::Bigtable::RowFilterError
    end
  end

  describe "#sample" do
    it "creates a sample probability filter" do
      probability = 0.5
      interleave_filter.filters.must_be :empty?
      interleave_filter.sample(probability)
      filter = assert_filter :row_sample_filter
      filter.to_grpc.row_sample_filter.must_equal probability
    end

    it "probability can not be greather then 1" do
      proc {
        interleave_filter.sample(1.1)
      }.must_raise Google::Cloud::Bigtable::RowFilterError
    end

    it "probability can not be equal to 1" do
      proc {
        interleave_filter.sample(1)
      }.must_raise Google::Cloud::Bigtable::RowFilterError
    end

    it "probability can not be equal to 0" do
      proc {
        interleave_filter.sample(0)
      }.must_raise Google::Cloud::Bigtable::RowFilterError
    end

    it "probability can not be less then 0" do
      proc {
        interleave_filter.sample(-0.1)
      }.must_raise Google::Cloud::Bigtable::RowFilterError
    end
  end

  it "creates a chain filter" do
    filter = Google::Cloud::Bigtable::RowFilter.chain
    interleave_filter.filters.must_be :empty?
    interleave_filter.chain filter
    assert_filter :chain, Google::Cloud::Bigtable::RowFilter::ChainFilter
  end

  it "creates an interleave filter" do
    filter = Google::Cloud::Bigtable::RowFilter.interleave
    interleave_filter.filters.must_be :empty?
    interleave_filter.interleave filter
    assert_filter :interleave, Google::Cloud::Bigtable::RowFilter::InterleaveFilter
  end

  it "creates a condition filter" do
    predicate = Google::Cloud::Bigtable::RowFilter.key("user-*")
    filter = Google::Cloud::Bigtable::RowFilter.condition(predicate)
    interleave_filter.filters.must_be :empty?
    interleave_filter.condition filter
    assert_filter :condition, Google::Cloud::Bigtable::RowFilter::ConditionFilter
  end

  def assert_filter method, type = Google::Cloud::Bigtable::RowFilter::SimpleFilter
    interleave_filter.filters.count.must_equal 1
    filter = interleave_filter.filters.find do |f|
      t = f.to_grpc.send method
      if t.kind_of? String # may be empty string in protobuf
        !t.empty?
      else
        !t.nil?
      end
    end
    filter.must_be_kind_of type
    filter
  end
end
