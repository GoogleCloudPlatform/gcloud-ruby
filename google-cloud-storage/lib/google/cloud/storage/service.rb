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


require "google/cloud/storage/version"
require "google/apis/storage_v1"
require "digest"
require "mime/types"
require "pathname"

module Google
  module Cloud
    module Storage
      ##
      # @private Represents the connection to Storage,
      # as well as expose the API calls.
      class Service
        ##
        # Alias to the Google Client API module
        API = Google::Apis::StorageV1

        # @private
        attr_accessor :project

        # @private
        attr_accessor :credentials

        ##
        # Creates a new Service instance.
        def initialize project, credentials, retries: nil, timeout: nil
          @project = project
          @credentials = credentials
          @credentials = credentials
          @service = API::StorageService.new
          @service.client_options.application_name    = "gcloud-ruby"
          @service.client_options.application_version = \
            Google::Cloud::Storage::VERSION
          @service.client_options.open_timeout_sec = timeout
          @service.client_options.read_timeout_sec = timeout
          @service.client_options.send_timeout_sec = timeout
          @service.request_options.retries = retries || 3
          @service.request_options.header ||= {}
          @service.request_options.header["x-goog-api-client"] = \
            "gl-ruby/#{RUBY_VERSION} gccl/#{Google::Cloud::Storage::VERSION}"
          @service.authorization = @credentials.client
        end

        def service
          return mocked_service if mocked_service
          @service
        end
        attr_accessor :mocked_service

        ##
        # Retrieves a list of buckets for the given project.
        def list_buckets prefix: nil, token: nil, max: nil
          execute do
            service.list_buckets @project, prefix: prefix, page_token: token,
                                           max_results: max
          end
        end

        ##
        # Retrieves bucket by name.
        # Returns Google::Apis::StorageV1::Bucket.
        def get_bucket bucket_name
          execute { service.get_bucket bucket_name }
        end

        ##
        # Creates a new bucket.
        # Returns Google::Apis::StorageV1::Bucket.
        def insert_bucket bucket_gapi, options = {}
          execute do
            service.insert_bucket \
              @project, bucket_gapi,
              predefined_acl: options[:acl],
              predefined_default_object_acl: options[:default_acl]
          end
        end

        ##
        # Updates a bucket, including its ACL metadata.
        def patch_bucket bucket_name, bucket_gapi = nil, predefined_acl: nil,
                         predefined_default_acl: nil
          bucket_gapi ||= Google::Apis::StorageV1::Bucket.new
          bucket_gapi.acl = [] if predefined_acl
          bucket_gapi.default_object_acl = [] if predefined_default_acl

          execute do
            service.patch_bucket \
              bucket_name, bucket_gapi,
              predefined_acl: predefined_acl,
              predefined_default_object_acl: predefined_default_acl
          end
        end

        ##
        # Permanently deletes an empty bucket.
        def delete_bucket bucket_name
          execute { service.delete_bucket bucket_name }
        end

        ##
        # Retrieves a list of ACLs for the given bucket.
        def list_bucket_acls bucket_name
          execute { service.list_bucket_access_controls bucket_name }
        end

        ##
        # Creates a new bucket ACL.
        def insert_bucket_acl bucket_name, entity, role
          new_acl = Google::Apis::StorageV1::BucketAccessControl.new({
            entity: entity, role: role }.delete_if { |_k, v| v.nil? })
          execute { service.insert_bucket_access_control bucket_name, new_acl }
        end

        ##
        # Permanently deletes a bucket ACL.
        def delete_bucket_acl bucket_name, entity
          execute { service.delete_bucket_access_control bucket_name, entity }
        end

        ##
        # Retrieves a list of default ACLs for the given bucket.
        def list_default_acls bucket_name
          execute { service.list_default_object_access_controls bucket_name }
        end

        ##
        # Creates a new default ACL.
        def insert_default_acl bucket_name, entity, role
          new_acl = Google::Apis::StorageV1::ObjectAccessControl.new({
            entity: entity, role: role }.delete_if { |_k, v| v.nil? })
          execute do
            service.insert_default_object_access_control bucket_name, new_acl
          end
        end

        ##
        # Permanently deletes a default ACL.
        def delete_default_acl bucket_name, entity
          execute do
            service.delete_default_object_access_control bucket_name, entity
          end
        end

        ##
        # Returns Google::Apis::StorageV1::Policy
        def get_bucket_policy bucket_name
          # get_bucket_iam_policy(bucket, fields: nil, quota_user: nil,
          #                               user_ip: nil, options: nil)
          execute { service.get_bucket_iam_policy bucket_name }
        end

        ##
        # Returns Google::Apis::StorageV1::Policy
        def set_bucket_policy bucket_name, new_policy
          execute do
            service.set_bucket_iam_policy bucket_name, new_policy
          end
        end

        ##
        # Returns Google::Apis::StorageV1::TestIamPermissionsResponse
        def test_bucket_permissions bucket_name, permissions
          execute do
            service.test_bucket_iam_permissions bucket_name, permissions
          end
        end

        ##
        # Retrieves a list of files matching the criteria.
        def list_files bucket_name, options = {}
          execute do
            service.list_objects \
              bucket_name, delimiter: options[:delimiter],
                           max_results: options[:max],
                           page_token: options[:token],
                           prefix: options[:prefix],
                           versions: options[:versions]
          end
        end

        ##
        # Inserts a new file for the given bucket
        def insert_file bucket_name, source, path = nil, acl: nil,
                        cache_control: nil, content_disposition: nil,
                        content_encoding: nil, content_language: nil,
                        content_type: nil, crc32c: nil, md5: nil, metadata: nil,
                        storage_class: nil, key: nil
          file_obj = Google::Apis::StorageV1::Object.new({
            cache_control: cache_control, content_type: content_type,
            content_disposition: content_disposition, md5_hash: md5,
            content_encoding: content_encoding, crc32c: crc32c,
            content_language: content_language, metadata: metadata,
            storage_class: storage_class }.delete_if { |_k, v| v.nil? })
          content_type ||= mime_type_for(path || Pathname(source).to_path)

          execute do
            service.insert_object \
              bucket_name, file_obj,
              name: path, predefined_acl: acl, upload_source: source,
              content_encoding: content_encoding, content_type: content_type,
              options: key_options(key)
          end
        end

        ##
        # Retrieves an object or its metadata.
        def get_file bucket_name, file_path, generation: nil, key: nil
          execute do
            service.get_object \
              bucket_name, file_path,
              generation: generation,
              options: key_options(key)
          end
        end

        ## Copy a file from source bucket/object to a
        # destination bucket/object.
        def copy_file source_bucket_name, source_file_path,
                      destination_bucket_name, destination_file_path,
                      file_gapi = nil, options = {}
          key_options = rewrite_key_options options[:key],
                                            options[:key]
          execute do
            service.rewrite_object \
              source_bucket_name, source_file_path,
              destination_bucket_name, destination_file_path,
              file_gapi,
              destination_predefined_acl: options[:acl],
              source_generation: options[:generation],
              rewrite_token: options[:token],
              options: key_options
          end
        end

        ## Rewrite a file from source bucket/object to a
        # destination bucket/object.
        def rewrite_file source_bucket_name, source_file_path,
                         destination_bucket_name, destination_file_path,
                         file_gapi = nil, options = {}
          key_options = rewrite_key_options options[:source_key],
                                            options[:destination_key]
          execute do
            service.rewrite_object \
              source_bucket_name, source_file_path,
              destination_bucket_name, destination_file_path,
              file_gapi,
              destination_predefined_acl: options[:acl],
              source_generation: options[:generation],
              rewrite_token: options[:token],
              options: key_options
          end
        end

        ##
        # Download contents of a file.
        def download_file bucket_name, file_path, target_path, generation: nil,
                          key: nil
          execute do
            service.get_object \
              bucket_name, file_path,
              download_dest: target_path, generation: generation,
              options: key_options(key)
          end
        end

        ##
        # Updates a file's metadata.
        def patch_file bucket_name, file_path, file_gapi = nil,
                       predefined_acl: nil
          file_gapi ||= Google::Apis::StorageV1::Object.new
          execute do
            service.patch_object \
              bucket_name, file_path, file_gapi,
              predefined_acl: predefined_acl
          end
        end

        ##
        # Permanently deletes a file.
        def delete_file bucket_name, file_path
          execute { service.delete_object bucket_name, file_path }
        end

        ##
        # Retrieves a list of ACLs for the given file.
        def list_file_acls bucket_name, file_name
          execute { service.list_object_access_controls bucket_name, file_name }
        end

        ##
        # Creates a new file ACL.
        def insert_file_acl bucket_name, file_name, entity, role, options = {}
          new_acl = Google::Apis::StorageV1::ObjectAccessControl.new({
            entity: entity, role: role }.delete_if { |_k, v| v.nil? })
          execute do
            service.insert_object_access_control \
              bucket_name, file_name, new_acl, generation: options[:generation]
          end
        end

        ##
        # Permanently deletes a file ACL.
        def delete_file_acl bucket_name, file_name, entity, options = {}
          execute do
            service.delete_object_access_control \
              bucket_name, file_name, entity, generation: options[:generation]
          end
        end

        ##
        # Returns Google::Apis::StorageV1::Policy
        def get_file_policy bucket_name, file_name
          # get_object_iam_policy(bucket, object, generation: nil, fields: nil,
          #                                       quota_user: nil, user_ip: nil,
          #                                       options: nil)
          execute { service.get_object_iam_policy bucket_name, file_name }
        end

        ##
        # Returns Google::Apis::StorageV1::Policy
        def set_file_policy bucket_name, file_name, new_policy
          # set_object_iam_policy(bucket, object, policy_object = nil,
          #                       generation: nil, fields: nil, quota_user: nil,
          #                       user_ip: nil, options: nil)
          execute do
            service.set_object_iam_policy bucket_name, file_name, new_policy
          end
        end

        ##
        # Returns Google::Apis::StorageV1::TestIamPermissionsResponse
        def test_file_permissions bucket_name, file_name, permissions
          execute do
            # test_object_iam_permissions(bucket, object, permissions,
            # generation: nil, fields: nil, quota_user: nil, user_ip: nil,
            # options: nil)
            service.test_object_iam_permissions bucket_name, file_name,
                                                permissions
          end
        end

        ##
        # Retrieves the mime-type for a file path.
        # An empty string is returned if no mime-type can be found.
        def mime_type_for path
          MIME::Types.of(path).first.to_s
        end

        # @private
        def inspect
          "#{self.class}(#{@project})"
        end

        protected

        def key_options key
          options = {}
          encryption_key_headers options, key if key
          options
        end

        def rewrite_key_options source_key, destination_key
          options = {}
          if source_key
            encryption_key_headers options, source_key, copy_source: true
          end
          encryption_key_headers options, destination_key if destination_key
          options
        end

        # @private
        # @param copy_source If true, header names are those for source object
        #   in rewrite request. If false, the header names are for use with any
        #   method supporting customer-supplied encryption keys.
        #   See https://cloud.google.com/storage/docs/encryption#request
        def encryption_key_headers options, key, copy_source: false
          source = copy_source ? "copy-source-" : ""
          key_sha256 = Digest::SHA256.digest key
          headers = (options[:header] ||= {})
          headers["x-goog-#{source}encryption-algorithm"] = "AES256"
          headers["x-goog-#{source}encryption-key"] = Base64.strict_encode64 key
          headers["x-goog-#{source}encryption-key-sha256"] = \
            Base64.strict_encode64 key_sha256
          options
        end

        def execute
          yield
        rescue Google::Apis::Error => e
          raise Google::Cloud::Error.from_error(e)
        end
      end
    end
  end
end
