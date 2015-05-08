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

module Gcloud
  module Storage
    ##
    # Base Storage exception class.
    class Error < Gcloud::Error
    end

    ##
    # Raised when an API call is not successful.
    class ApiError < Error
      ##
      # The code of the error.
      attr_reader :code

      ##
      # The errors encountered.
      attr_reader :errors

      def initialize message, code, errors
        super message
        @code   = code
        @errors = errors
      end

      def self.from_response resp #:nodoc:
        new resp.data["error"]["message"],
            resp.data["error"]["code"],
            resp.data["error"]["errors"]
      end
    end

    ##
    # Raised when a File download fails the verification.
    class FileVerificationError < Error
      ##
      # The type of digest that failed verification,
      # :md5 or :crc32c.
      attr_accessor :type

      ##
      # The value of the digest on the Gcloud file.
      attr_accessor :gcloud_digest

      ##
      # The value of the digest on the downloaded file.
      attr_accessor :local_digest

      def self.for_md5 gcloud_digest, local_digest #:nodoc:
        new("The downloaded file failed MD5 verification.").tap do |e|
          e.type = :md5
          e.gcloud_digest = gcloud_digest
          e.local_digest = local_digest
        end
      end

      def self.for_crc32c gcloud_digest, local_digest #:nodoc:
        new("The downloaded file failed CRC32c verification.").tap do |e|
          e.type = :crc32c
          e.gcloud_digest = gcloud_digest
          e.local_digest = local_digest
        end
      end
    end
  end
end
