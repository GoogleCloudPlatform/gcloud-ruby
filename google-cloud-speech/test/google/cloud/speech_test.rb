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

describe Google::Cloud do
  describe "#speech" do
    it "calls out to Google::Cloud.speech" do
      gcloud = Google::Cloud.new
      stubbed_speech = ->(project, keyfile, scope: nil, timeout: nil, client_config: nil) {
        project.must_be :nil?
        keyfile.must_be :nil?
        scope.must_be :nil?
        timeout.must_be :nil?
        client_config.must_be :nil?
        "speech-project-object-empty"
      }
      Google::Cloud.stub :speech, stubbed_speech do
        project = gcloud.speech
        project.must_equal "speech-project-object-empty"
      end
    end

    it "passes project and keyfile to Google::Cloud.speech" do
      gcloud = Google::Cloud.new "project-id", "keyfile-path"
      stubbed_speech = ->(project, keyfile, scope: nil, timeout: nil, client_config: nil) {
        project.must_equal "project-id"
        keyfile.must_equal "keyfile-path"
        scope.must_be :nil?
        timeout.must_be :nil?
        client_config.must_be :nil?
        "speech-project-object"
      }
      Google::Cloud.stub :speech, stubbed_speech do
        project = gcloud.speech
        project.must_equal "speech-project-object"
      end
    end

    it "passes project and keyfile and options to Google::Cloud.speech" do
      gcloud = Google::Cloud.new "project-id", "keyfile-path"
      stubbed_speech = ->(project, keyfile, scope: nil, timeout: nil, client_config: nil) {
        project.must_equal "project-id"
        keyfile.must_equal "keyfile-path"
        scope.must_equal "http://example.com/scope"
        timeout.must_equal 60
        client_config.must_equal({ "gax" => "options" })
        "speech-project-object-scoped"
      }
      Google::Cloud.stub :speech, stubbed_speech do
        project = gcloud.speech scope: "http://example.com/scope", timeout: 60, client_config: { "gax" => "options" }
        project.must_equal "speech-project-object-scoped"
      end
    end
  end

  describe ".speech" do
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
          Google::Cloud::Speech::Credentials.stub :default, default_credentials do
            speech = Google::Cloud.speech
            speech.must_be_kind_of Google::Cloud::Speech::Project
            speech.project.must_equal "project-id"
            speech.service.credentials.must_equal default_credentials
          end
        end
      end
    end

    it "uses provided project_id and keyfile" do
      stubbed_credentials = ->(keyfile, scope: nil) {
        keyfile.must_equal "path/to/keyfile.json"
        scope.must_be :nil?
        "speech-credentials"
      }
      stubbed_service = ->(project, credentials, timeout: nil, client_config: nil) {
        project.must_equal "project-id"
        credentials.must_equal "speech-credentials"
        timeout.must_be :nil?
        client_config.must_be :nil?
        OpenStruct.new project: project
      }

      # Clear all environment variables
      ENV.stub :[], nil do
        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::Speech::Credentials.stub :new, stubbed_credentials do
              Google::Cloud::Speech::Service.stub :new, stubbed_service do
                speech = Google::Cloud.speech "project-id", "path/to/keyfile.json"
                speech.must_be_kind_of Google::Cloud::Speech::Project
                speech.project.must_equal "project-id"
                speech.service.must_be_kind_of OpenStruct
              end
            end
          end
        end
      end
    end
  end

  describe "Speech.new" do
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
          Google::Cloud::Speech::Credentials.stub :default, default_credentials do
            speech = Google::Cloud::Speech.new
            speech.must_be_kind_of Google::Cloud::Speech::Project
            speech.project.must_equal "project-id"
            speech.service.credentials.must_equal default_credentials
          end
        end
      end
    end

    it "uses provided project_id and credentials" do
      stubbed_credentials = ->(keyfile, scope: nil) {
        keyfile.must_equal "path/to/keyfile.json"
        scope.must_be :nil?
        "speech-credentials"
      }
      stubbed_service = ->(project, credentials, timeout: nil, client_config: nil) {
        project.must_equal "project-id"
        credentials.must_equal "speech-credentials"
        timeout.must_be :nil?
        client_config.must_be :nil?
        OpenStruct.new project: project
      }

      # Clear all environment variables
      ENV.stub :[], nil do
        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::Speech::Credentials.stub :new, stubbed_credentials do
              Google::Cloud::Speech::Service.stub :new, stubbed_service do
                speech = Google::Cloud::Speech.new project_id: "project-id", credentials: "path/to/keyfile.json"
                speech.must_be_kind_of Google::Cloud::Speech::Project
                speech.project.must_equal "project-id"
                speech.service.must_be_kind_of OpenStruct
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
        "speech-credentials"
      }
      stubbed_service = ->(project, credentials, timeout: nil, client_config: nil) {
        project.must_equal "project-id"
        credentials.must_equal "speech-credentials"
        timeout.must_be :nil?
        client_config.must_be :nil?
        OpenStruct.new project: project
      }

      # Clear all environment variables
      ENV.stub :[], nil do
        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::Speech::Credentials.stub :new, stubbed_credentials do
              Google::Cloud::Speech::Service.stub :new, stubbed_service do
                speech = Google::Cloud::Speech.new project: "project-id", keyfile: "path/to/keyfile.json"
                speech.must_be_kind_of Google::Cloud::Speech::Project
                speech.project.must_equal "project-id"
                speech.service.must_be_kind_of OpenStruct
              end
            end
          end
        end
      end
    end
  end
end
