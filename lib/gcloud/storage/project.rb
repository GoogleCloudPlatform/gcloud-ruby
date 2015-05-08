#--
# Copyright 2014 Google Inc. All rights reserved.
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

require "gcloud/storage/errors"
require "gcloud/storage/connection"
require "gcloud/storage/credentials"
require "gcloud/storage/bucket"
require "gcloud/storage/file"

module Gcloud
  module Storage
    ##
    # Represents the Project that the Buckets and Files belong to.
    #
    # Gcloud::Storage::Project is the main object for interacting with
    # Google Storage. Gcloud::Storage::Bucket objects are created,
    # read, updated, and deleted by Gcloud::Storage::Project.
    #
    #   storage = Gcloud.storage "my-todo-project",
    #                            "/path/to/keyfile.json"
    #   bucket = storage.find_bucket "my-bucket"
    #   file = bucket.find_file "path/to/my-file.ext"
    #
    # See Gcloud.storage
    class Project
      ##
      # The Connection object.
      attr_accessor :connection #:nodoc:

      ##
      # Creates a new Project instance.
      #
      # See Gcloud.storage
      def initialize project, credentials #:nodoc:
        @connection = Connection.new project, credentials
      end

      ##
      # The project identifier.
      def project
        connection.project
      end

      ##
      # Default project.
      def self.default_project #:nodoc:
        ENV["STORAGE_PROJECT"] || ENV["GOOGLE_CLOUD_PROJECT"]
      end

      ##
      # Retrieves a list of buckets for the given project.
      #
      #   storage = Gcloud.storage
      #   buckets = storage.buckets
      #   buckets.each do |bucket|
      #     puts bucket.name
      #   end
      #
      # See Gcloud::Storage::Bucket
      def buckets options = {}
        resp = connection.list_buckets options
        if resp.success?
          Bucket::List.from_resp resp, connection
        else
          fail ApiError.from_response(resp)
        end
      end

      ##
      # Retrieves bucket by name.
      #
      #   storage = Gcloud.storage
      #   bucket = storage.find_bucket "my-bucket"
      #   puts bucket.name
      #
      # See Gcloud::Storage::Bucket
      def find_bucket bucket_name
        resp = connection.get_bucket bucket_name
        if resp.success?
          Bucket.from_gapi resp.data, connection
        else
          return nil if resp.data["error"]["code"] == 404
          fail ApiError.from_response(resp)
        end
      end

      ##
      # Creates a new bucket.
      #
      #   bucket = project.create_bucket "my-bucket"
      #
      # The API call to create the bucket may be retried under certain
      # conditions. See Gcloud::Backoff to control this behavior, or
      # specify the wanted behavior in the call:
      #
      #   bucket = project.create_bucket "my-bucket", retries: 5
      #
      # See Gcloud::Storage::Bucket
      def create_bucket bucket_name, options = {}
        options[:acl] = Bucket::Acl.predefined_rule_for options[:acl]
        default_acl = options[:default_acl]
        default_acl = Bucket::DefaultAcl.predefined_rule_for default_acl
        options[:default_acl] = default_acl

        resp = connection.insert_bucket bucket_name, options
        if resp.success?
          Bucket.from_gapi resp.data, connection
        else
          fail ApiError.from_response(resp)
        end
      end
    end
  end
end
