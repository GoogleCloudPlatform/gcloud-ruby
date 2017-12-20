# Copyright 2016 Google LLC
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
require "google/cloud/bigquery"

describe Google::Cloud do
  describe "#bigquery" do
    it "calls out to Google::Cloud.bigquery" do
      gcloud = Google::Cloud.new
      stubbed_bigquery = ->(project, keyfile, scope: nil, retries: nil, timeout: nil) {
        project.must_be :nil?
        keyfile.must_be :nil?
        scope.must_be :nil?
        retries.must_be :nil?
        timeout.must_be :nil?
        "bigquery-project-object-empty"
      }
      Google::Cloud.stub :bigquery, stubbed_bigquery do
        project = gcloud.bigquery
        project.must_equal "bigquery-project-object-empty"
      end
    end

    it "passes project and keyfile to Google::Cloud.bigquery" do
      gcloud = Google::Cloud.new "project-id", "keyfile-path"
      stubbed_bigquery = ->(project, keyfile, scope: nil, retries: nil, timeout: nil) {
        project.must_equal "project-id"
        keyfile.must_equal "keyfile-path"
        scope.must_be :nil?
        retries.must_be :nil?
        timeout.must_be :nil?
        "bigquery-project-object"
      }
      Google::Cloud.stub :bigquery, stubbed_bigquery do
        project = gcloud.bigquery
        project.must_equal "bigquery-project-object"
      end
    end

    it "passes project and keyfile and options to Google::Cloud.bigquery" do
      gcloud = Google::Cloud.new "project-id", "keyfile-path"
      stubbed_bigquery = ->(project, keyfile, scope: nil, retries: nil, timeout: nil) {
        project.must_equal "project-id"
        keyfile.must_equal "keyfile-path"
        scope.must_equal "http://example.com/scope"
        retries.must_equal 5
        timeout.must_equal 60
        "bigquery-project-object-scoped"
      }
      Google::Cloud.stub :bigquery, stubbed_bigquery do
        project = gcloud.bigquery scope: "http://example.com/scope", retries: 5, timeout: 60
        project.must_equal "bigquery-project-object-scoped"
      end
    end
  end

  describe ".bigquery" do
    let(:default_credentials) do
      creds = OpenStruct.new empty: true
      def creds.is_a? target
        target == Google::Auth::Credentials
      end
      creds
    end
    let(:found_credentials) { "{}" }

    it "gets defaults for project_id and keyfile" do
      # Clear all environment variables
      ENV.stub :[], nil do
        # Get project_id from Google Compute Engine
        Google::Cloud.stub :env, OpenStruct.new(project_id: "project-id") do
          Google::Cloud::BigQuery::Credentials.stub :default, default_credentials do
            bigquery = Google::Cloud.bigquery
            bigquery.must_be_kind_of Google::Cloud::BigQuery::Project
            bigquery.project.must_equal "project-id"
            bigquery.service.credentials.must_equal default_credentials
          end
        end
      end
    end

    it "uses provided project_id and keyfile" do
      stubbed_credentials = ->(keyfile, scope: nil) {
        keyfile.must_equal "path/to/keyfile.json"
        scope.must_be :nil?
        "bigquery-credentials"
      }
      stubbed_service = ->(project, credentials, retries: nil, timeout: nil) {
        project.must_equal "project-id"
        credentials.must_equal "bigquery-credentials"
        retries.must_be :nil?
        timeout.must_be :nil?
        OpenStruct.new project: project
      }

      # Clear all environment variables
      ENV.stub :[], nil do
        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::BigQuery::Credentials.stub :new, stubbed_credentials do
              Google::Cloud::BigQuery::Service.stub :new, stubbed_service do
                bigquery = Google::Cloud.bigquery "project-id", "path/to/keyfile.json"
                bigquery.must_be_kind_of Google::Cloud::BigQuery::Project
                bigquery.project.must_equal "project-id"
                bigquery.service.must_be_kind_of OpenStruct
              end
            end
          end
        end
      end
    end
  end

  describe "BigQuery.new" do
    let(:default_credentials) do
      creds = OpenStruct.new empty: true
      def creds.is_a? target
        target == Google::Auth::Credentials
      end
      creds
    end
    let(:found_credentials) { "{}" }

    it "gets defaults for project_id and keyfile" do
      # Clear all environment variables
      ENV.stub :[], nil do
        # Get project_id from Google Compute Engine
        Google::Cloud.stub :env, OpenStruct.new(project_id: "project-id") do
          Google::Cloud::BigQuery::Credentials.stub :default, default_credentials do
            bigquery = Google::Cloud::BigQuery.new
            bigquery.must_be_kind_of Google::Cloud::BigQuery::Project
            bigquery.project.must_equal "project-id"
            bigquery.service.credentials.must_equal default_credentials
          end
        end
      end
    end

    it "uses provided project_id and credentials" do
      stubbed_credentials = ->(keyfile, scope: nil) {
        keyfile.must_equal "path/to/keyfile.json"
        scope.must_be :nil?
        "bigquery-credentials"
      }
      stubbed_service = ->(project, credentials, retries: nil, timeout: nil) {
        project.must_equal "project-id"
        credentials.must_equal "bigquery-credentials"
        retries.must_be :nil?
        timeout.must_be :nil?
        OpenStruct.new project: project
      }

      # Clear all environment variables
      ENV.stub :[], nil do
        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::BigQuery::Credentials.stub :new, stubbed_credentials do
              Google::Cloud::BigQuery::Service.stub :new, stubbed_service do
                bigquery = Google::Cloud::BigQuery.new project_id: "project-id", credentials: "path/to/keyfile.json"
                bigquery.must_be_kind_of Google::Cloud::BigQuery::Project
                bigquery.project.must_equal "project-id"
                bigquery.service.must_be_kind_of OpenStruct
              end
            end
          end
        end
      end
    end

    it "uses provided project and keyfile aliases" do
      stubbed_credentials = ->(keyfile, scope: nil) {
        keyfile.must_equal "path/to/keyfile.json"
        scope.must_be :nil?
        "bigquery-credentials"
      }
      stubbed_service = ->(project, credentials, retries: nil, timeout: nil) {
        project.must_equal "project-id"
        credentials.must_equal "bigquery-credentials"
        retries.must_be :nil?
        timeout.must_be :nil?
        OpenStruct.new project: project
      }

      # Clear all environment variables
      ENV.stub :[], nil do
        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::BigQuery::Credentials.stub :new, stubbed_credentials do
              Google::Cloud::BigQuery::Service.stub :new, stubbed_service do
                bigquery = Google::Cloud::BigQuery.new project: "project-id", keyfile: "path/to/keyfile.json"
                bigquery.must_be_kind_of Google::Cloud::BigQuery::Project
                bigquery.project.must_equal "project-id"
                bigquery.service.must_be_kind_of OpenStruct
              end
            end
          end
        end
      end
    end
  end

  it "maintains the previous namespace" do
    Google::Cloud::Bigquery.must_equal Google::Cloud::BigQuery
  end
end
