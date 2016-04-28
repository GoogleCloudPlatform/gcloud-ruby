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


require "gcloud/vision/location"
require "gcloud/vision/analysis/vertex"

module Gcloud
  module Vision
    class Analysis
      ##
      # # Entity
      class Entity
        ##
        # @private The EntityAnnotation Google API Client object.
        attr_accessor :gapi

        ##
        # @private Creates a new Entity instance.
        def initialize
          @gapi = {}
        end

        ##
        # Opaque entity ID. Some IDs might be available in Knowledge Graph(KG).
        #
        # @see https://developers.google.com/knowledge-graph/
        def mid
          @gapi["mid"]
        end

        ##
        # The language code for the locale in which the `description` is
        # expressed.
        def locale
          @gapi["locale"]
        end

        ##
        # Entity textual description, expressed in the `locale` language.
        def description
          @gapi["description"]
        end

        ##
        # Overall score of the result. Range [0, 1].
        def score
          @gapi["score"]
        end

        ##
        # The accuracy of the entity detection in an image. For example, for an
        # image containing 'Eiffel Tower,' this field represents the confidence
        # that there is a tower in the query image. Range [0, 1].
        def confidence
          @gapi["confidence"]
        end

        ##
        # The relevancy of the ICA (Image Content Annotation) label to the
        # image. For example, the relevancy of 'tower' to an image containing
        # 'Eiffel Tower' is likely higher than an image containing a distant
        # towering building, though the confidence that there is a tower may be
        # the same. Range [0, 1].
        def topicality
          @gapi["topicality"]
        end

        ##
        # Image region to which this entity belongs. Not filled currently for
        # `labels` detection. For `text` detection bounds are
        # produced for the entire text detected in an image region, followed by
        # bounds for each word within the detected text.
        def bounds
          return [] unless @gapi["boundingPoly"]
          @bounds ||= Array(@gapi["boundingPoly"]["vertices"]).map do |v|
            Vertex.from_gapi v
          end
        end

        ##
        # The location information for the detected entity. Multiple Location
        # elements can be present since one location may indicate the location
        # of the scene in the query image, and another the location of the place
        # where the query image was taken. Location information is usually
        # present for landmarks.
        def locations
          @locations ||= Array(@gapi["locations"]).map do |l|
            Location.from_gapi l["latLng"]
          end
        end

        ##
        # Some entities can have additional optional Property fields. For
        # example a different kind of score or string that qualifies the entity.
        def properties
          @properties ||=
            Hash[Array(@gapi["properties"]).map { |p| [p["name"], p["value"]] }]
        end

        def to_h
          to_hash
        end

        def to_hash
          { mid: mid, locale: locale, description: description,
            score: score, confidence: confidence, topicality: topicality,
            bounds: bounds.map(&:to_h), locations: locations.map(&:to_h),
            properties: properties }
        end

        def to_s
          tmplt = "mid: %s, locale: %s, description: %s, score: %s, " \
                  "confidence: %s, topicality: %s, bounds: %i, " \
                  "locations: %i, properties: %s"
          format tmplt, mid.inspect, locale.inspect, description.inspect,
                 score.inspect, confidence.inspect, topicality.inspect,
                 bounds.count, locations.count, properties.inspect
        end

        def inspect
          "#<#{self.class.name} #{self}>"
        end

        ##
        # @private New Analysis::Entity from a Google API Client object.
        def self.from_gapi gapi
          new.tap { |f| f.instance_variable_set :@gapi, gapi }
        end
      end
    end
  end
end
