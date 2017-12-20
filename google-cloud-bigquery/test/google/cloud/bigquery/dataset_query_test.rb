# Copyright 2015 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a extract of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "helper"

describe Google::Cloud::BigQuery::Dataset, :query, :mock_bigquery do
  let(:query) { "SELECT * FROM `some_project.some_dataset.users`" }

  let(:job_id) { "job_9876543210" }
  let(:dataset_id) { "my_dataset" }
  let(:dataset_gapi) { random_dataset_gapi dataset_id }
  let(:dataset) { Google::Cloud::BigQuery::Dataset.from_gapi dataset_gapi,
                                                      bigquery.service }

  it "queries the data with default dataset option set" do
    mock = Minitest::Mock.new
    bigquery.service.mocked_service = mock

    job_gapi = query_job_gapi query, dataset: dataset_id

    mock.expect :insert_job, query_job_resp_gapi(query, job_id: job_id), [project, job_gapi]
    mock.expect :get_job_query_results,
                query_data_gapi,
                [project, job_id, {max_results: 0, page_token: nil, start_index: nil, timeout_ms: nil}]
    mock.expect :list_table_data,
                table_data_gapi.to_json,
                [project, "target_dataset_id", "target_table_id", {  max_results: nil, page_token: nil, start_index: nil, options: {skip_deserialization: true} }]

    data = dataset.query query
    data.class.must_equal Google::Cloud::BigQuery::Data
    data.count.must_equal 3
    mock.verify
  end

  describe "dataset reference" do
    let(:dataset) {Google::Cloud::BigQuery::Dataset.new_reference project, dataset_id, bigquery.service }

    it "queries the data with default dataset option set" do
      mock = Minitest::Mock.new
      bigquery.service.mocked_service = mock

      job_gapi = query_job_gapi query, dataset: dataset_id

      mock.expect :insert_job, query_job_resp_gapi(query, job_id: job_id), [project, job_gapi]
      mock.expect :get_job_query_results,
                  query_data_gapi,
                  [project, job_id, {max_results: 0, page_token: nil, start_index: nil, timeout_ms: nil}]
      mock.expect :list_table_data,
                  table_data_gapi.to_json,
                  [project, "target_dataset_id", "target_table_id", {  max_results: nil, page_token: nil, start_index: nil, options: {skip_deserialization: true} }]

      data = dataset.query query
      data.class.must_equal Google::Cloud::BigQuery::Data
      data.count.must_equal 3
      mock.verify
    end
  end

  it "raises when the job fails with reason accessDenied" do
    mock = Minitest::Mock.new
    bigquery.service.mocked_service = mock

    job_gapi = query_job_gapi query, dataset: dataset_id

    mock.expect :insert_job, failed_query_job_resp_gapi(query, job_id: job_id, reason: "accessDenied"), [project, job_gapi]

    err = expect { dataset.query query }.must_raise Google::Cloud::PermissionDeniedError
    err.message.must_equal "string"
    err.cause.body.must_equal({
      "debugInfo"=>"string",
      "location"=>"string",
      "message"=>"string",
      "reason"=>"accessDenied",
      "errors"=>[{
        "debugInfo"=>"string",
        "location"=>"string",
        "message"=>"string",
        "reason"=>"accessDenied"
      }]
    })

    mock.verify
  end

  it "raises when the job fails with reason backendError" do
    mock = Minitest::Mock.new
    bigquery.service.mocked_service = mock

    job_gapi = query_job_gapi query, dataset: dataset_id

    mock.expect :insert_job, failed_query_job_resp_gapi(query, job_id: job_id, reason: "backendError"), [project, job_gapi]

    err = expect { dataset.query query }.must_raise Google::Cloud::InternalError
    err.message.must_equal "string"
    err.cause.body.must_equal({
      "debugInfo"=>"string",
      "location"=>"string",
      "message"=>"string",
      "reason"=>"backendError",
      "errors"=>[{
        "debugInfo"=>"string",
        "location"=>"string",
        "message"=>"string",
        "reason"=>"backendError"
      }]
    })

    mock.verify
  end
end
