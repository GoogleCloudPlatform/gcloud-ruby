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

require "helper"
require "logger"

describe Google::Cloud::Logging::Logger, :mock_logging do
  let(:log_name) { "web_app_log" }
  let(:resource) do
    Google::Cloud::Logging::Resource.new.tap do |r|
      r.type = "gce_instance"
      r.labels["zone"] = "global"
      r.labels["instance_id"] = "abc123"
    end
  end
  let(:labels) { { "env" => "production" } }
  let(:logger) { Google::Cloud::Logging::Logger.new logging, log_name, resource, labels }
  let(:write_res) { Google::Logging::V2::WriteLogEntriesResponse.new }

  def write_req severity
    Google::Logging::V2::WriteLogEntriesRequest.new(
      log_name: "projects/test/logs/web_app_log",
      resource: resource.to_grpc,
      labels: labels,
      entries: [Google::Logging::V2::LogEntry.new(
        text_payload: "Danger Will Robinson!", severity: severity
      )]
    )
  end

  it "creates a DEBUG log entry with #debug" do
    mock = Minitest::Mock.new
    mock.expect :write_log_entries, write_res, [write_req(:DEBUG)]
    logging.service.mocked_logging = mock

    logger.debug "Danger Will Robinson!"

    mock.verify
  end

  it "creates an INFO log entry with #info" do
    mock = Minitest::Mock.new
    mock.expect :write_log_entries, write_res, [write_req(:INFO)]
    logging.service.mocked_logging = mock

    logger.info "Danger Will Robinson!"

    mock.verify
  end

  it "creates a WARNING log entry with #warn" do
    mock = Minitest::Mock.new
    mock.expect :write_log_entries, write_res, [write_req(:WARNING)]
    logging.service.mocked_logging = mock

    logger.warn "Danger Will Robinson!"

    mock.verify
  end

  it "creates a ERROR log entry with #error" do
    mock = Minitest::Mock.new
    mock.expect :write_log_entries, write_res, [write_req(:ERROR)]
    logging.service.mocked_logging = mock

    logger.error "Danger Will Robinson!"

    mock.verify
  end

  it "creates a CRITICAL log entry with #fatal" do
    mock = Minitest::Mock.new
    mock.expect :write_log_entries, write_res, [write_req(:CRITICAL)]
    logging.service.mocked_logging = mock

    logger.fatal "Danger Will Robinson!"

    mock.verify
  end

  it "creates a DEFAULT log entry with #unknown" do
    mock = Minitest::Mock.new
    mock.expect :write_log_entries, write_res, [write_req(:DEFAULT)]
    logging.service.mocked_logging = mock

    logger.unknown "Danger Will Robinson!"

    mock.verify
  end

  it "catches Google::Cloud::Error exceptions" do
    mock = Minitest::Mock.new
    def mock.write_log_entries message 
      raise Google::Cloud::UnavailableError.new "This mock error should be caught"
    end
    # mock.expect :write_log_entries, write_res, [write_req(:INFO)]
    logging.service.mocked_logging = mock

    logger.info "Danger Will Robinson!"

    mock.verify
  end

  it "should raise Standard exceptions" do
    mock = Minitest::Mock.new
    def mock.write_log_entries message 
      raise "This mock error should not be caught"
    end

    logging.service.mocked_logging = mock

    err = ->{ logger.info "Danger Will Robinson!" }.must_raise RuntimeError
  end
end
