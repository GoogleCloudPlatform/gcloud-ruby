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


require "delegate"

module Gcloud
  module Translate
    ##
    # TODO
    class Translation < DelegateClass(::String)
      ##
      # The that was translated.
      #
      # @return [String]
      attr_reader :origin

      ##
      # The target language the text was translated to.
      #
      # @return [String]
      attr_reader :to
      alias_method :language, :to
      alias_method :target, :to

      ##
      # The source language the text was translated from.
      attr_reader :from
      alias_method :source, :from

      ##
      # @private Create a new object.
      def initialize text, to, origin, from, detected
        super text
        @to = to
        @origin = origin
        @from = from
        @detected = detected
      end

      ##
      # The translated text.
      #
      # @return [String]
      def text
        __getobj__
      end

      ##
      # Determines if the source language the text was translated from was
      # detected by the Google Cloud Translate API.
      #
      # @return [Boolean]
      def detected?
        @detected
      end

      ##
      # @private New Translation from a TranslationsListResponse object as
      # defined by the Google API Client object.
      def self.from_response resp, text, to, from
        res = text.zip(Array(resp.data["translations"])).map do |origin, gapi|
          from_gapi gapi, to, origin, from
        end
        return res.first if res.size == 1
        res
      end

      ##
      # @private New Translation from a TranslationsResource object as defined
      # by the Google API Client object.
      def self.from_gapi gapi, to, origin, from
        from ||= gapi["detectedSourceLanguage"]
        detected = !gapi["detectedSourceLanguage"].nil?
        new gapi["translatedText"], to, origin, from, detected
      end
    end
  end
end
