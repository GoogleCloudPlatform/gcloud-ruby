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


require "stringio"
require "base64"

module Gcloud
  module Vision
    ##
    # # Image
    #
    # Represents an image for the Vision service.
    #
    # @example
    #   require "gcloud"
    #
    #   gcloud = Gcloud.new
    #   vision = gcloud.vision
    #   image = vision.image filepath
    class Image
      ##
      # @private Creates a new Image instance.
      def initialize
        @io = nil
        @url = nil
      end

      # Determines if the Image has content.
      #
      # @see {#url?}
      #
      def content?
        !@io.nil?
      end

      # Determines if the Image is a URL.
      #
      # @see {#content?}
      #
      def url?
        !@url.nil?
      end

      ##
      # The contents of the image, encoded via Base64.
      def content
        @content ||= Base64.encode64 @io.read
      end

      ##
      # The URL of the image
      def url
        @url
      end

      def to_s
        return "(io)" if content?
        "(url: #{url})"
      end

      def inspect
        "#<#{self.class.name} #{self}>"
      end

      ##
      # @private The Google API Client object for the Image.
      def to_gapi
        if content?
          { content: content }
        elsif url?
          { source: { gcsImageUri: @url } }
        else
          fail ArgumentError, "Unable to use Image with Vision service."
        end
      end

      ##
      # @private New Image from a source object.
      def self.from_source source
        return from_io(source) if source.is_a?(IO) || source.is_a?(StringIO)
        # Convert Storage::File objects to the URL
        source = source.to_gs_url if source.respond_to? :to_gs_url
        # Everything should be a string from now on
        source = String source
        # Create an Image from the Google Storage URL
        return from_url(source) if source.start_with? "gs://"
        # Create an image from a file on the filesystem
        if File.file? source
          unless File.readable? source
            fail ArgumentError, "Cannot read #{source}"
          end
          return from_io(File.open(source, "rb"))
        end
        fail ArgumentError, "Unable to convert #{source} to an Image"
      end

      ##
      # @private New Image from an IO object.
      def self.from_io io
        if !io.is_a?(IO) && !io.is_a?(StringIO)
          puts io.inspect
          fail ArgumentError, "Cannot create an Image without an IO object"
        end
        new.tap { |i| i.instance_variable_set :@io, io }
      end

      ##
      # @private New Image from an IO object.
      def self.from_url url
        url = String url
        unless url.start_with? "gs://"
          fail ArgumentError, "Cannot create an Image without a Storage URL"
        end
        new.tap { |i| i.instance_variable_set :@url, url }
      end
    end
  end
end
