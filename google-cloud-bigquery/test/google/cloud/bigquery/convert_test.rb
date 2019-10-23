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

describe Google::Cloud::Bigquery::Convert do
  let(:time_object) { Time.parse "2014-10-02T15:01:23.045Z" }
  let(:time_millis) { 1412262083045 }

  describe :millis_to_time do
    it "converts nil to nil with no error" do
      Google::Cloud::Bigquery::Convert.millis_to_time(nil).must_be :nil?
    end

    it "converts time in millis to a Time object with same value in seconds" do
      converted_time = Google::Cloud::Bigquery::Convert.millis_to_time time_millis
      converted_time.must_be_kind_of ::Time
      converted_time.must_equal time_object
    end
  end

  describe :time_to_millis do
    it "converts nil to nil with no error" do
      Google::Cloud::Bigquery::Convert.time_to_millis(nil).must_be :nil?
    end

    it "converts time in millis to a Time object with same value in seconds" do
      converted_millis = Google::Cloud::Bigquery::Convert.time_to_millis time_object
      converted_millis.must_be_kind_of ::Integer
      converted_millis.must_equal time_millis
    end
  end

  describe :format_value do
    it "converts all floats correctly" do
      float_type = Google::Apis::BigqueryV2::TableFieldSchema.new(type: "FLOAT")

      f = Google::Cloud::Bigquery::Convert.format_value({ v: "3.333" }, float_type)
      f.must_be_kind_of ::Float
      f.must_equal 3.333

      f = Google::Cloud::Bigquery::Convert.format_value({ v: "Infinity" }, float_type)
      f.must_be_kind_of ::Float
      f.must_equal Float::INFINITY

      f = Google::Cloud::Bigquery::Convert.format_value({ v: "-Infinity" }, float_type)
      f.must_be_kind_of ::Float
      f.must_equal -Float::INFINITY

      f = Google::Cloud::Bigquery::Convert.format_value({ v: "NaN" }, float_type)
      f.must_be_kind_of ::Float
      f.must_be :nan?
    end
  end

  describe :to_query_param do
    it "converts an array correctly" do
      f = Google::Cloud::Bigquery::Convert.to_query_param([1, 2])
      f.must_be_kind_of Google::Apis::BigqueryV2::QueryParameter
      f.to_h.must_equal({
        parameter_type: { array_type: { type: "INT64" }, type: "ARRAY" },
        parameter_value: { array_values: [{ value: 1 }, { value: 2 }] }
      })
    end

    it "converts an empty array correctly" do
      f = Google::Cloud::Bigquery::Convert.to_query_param([])
      f.must_be_kind_of Google::Apis::BigqueryV2::QueryParameter
      f.to_h.must_equal({
        parameter_type: { array_type: { type: "STRING" }, type: "ARRAY" },
        parameter_value: { array_values: [] }
      })
    end
  end
end
