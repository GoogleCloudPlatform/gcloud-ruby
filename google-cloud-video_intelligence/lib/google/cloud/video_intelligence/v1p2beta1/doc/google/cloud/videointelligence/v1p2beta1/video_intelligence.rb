# Copyright 2020 Google LLC
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


module Google
  module Cloud
    module VideoIntelligence
      module V1p2beta1
        # Video annotation request.
        # @!attribute [rw] input_uri
        #   @return [String]
        #     Input video location. Currently, only
        #     [Google Cloud Storage](https://cloud.google.com/storage/) URIs are
        #     supported, which must be specified in the following format:
        #     `gs://bucket-id/object-id` (other URI formats return
        #     {Google::Rpc::Code::INVALID_ARGUMENT}). For more information, see
        #     [Request URIs](https://cloud.google.com/storage/docs/reference-uris).
        #     A video URI may include wildcards in `object-id`, and thus identify
        #     multiple videos. Supported wildcards: '*' to match 0 or more characters;
        #     '?' to match 1 character. If unset, the input video should be embedded
        #     in the request as `input_content`. If set, `input_content` should be unset.
        # @!attribute [rw] input_content
        #   @return [String]
        #     The video data bytes.
        #     If unset, the input video(s) should be specified via `input_uri`.
        #     If set, `input_uri` should be unset.
        # @!attribute [rw] features
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::Feature>]
        #     Required. Requested video annotation features.
        # @!attribute [rw] video_context
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::VideoContext]
        #     Additional video context and/or feature-specific parameters.
        # @!attribute [rw] output_uri
        #   @return [String]
        #     Optional. Location where the output (in JSON format) should be stored.
        #     Currently, only [Google Cloud Storage](https://cloud.google.com/storage/)
        #     URIs are supported, which must be specified in the following format:
        #     `gs://bucket-id/object-id` (other URI formats return
        #     {Google::Rpc::Code::INVALID_ARGUMENT}). For more information, see
        #     [Request URIs](https://cloud.google.com/storage/docs/reference-uris).
        # @!attribute [rw] location_id
        #   @return [String]
        #     Optional. Cloud region where annotation should take place. Supported cloud
        #     regions: `us-east1`, `us-west1`, `europe-west1`, `asia-east1`. If no region
        #     is specified, a region will be determined based on video file location.
        class AnnotateVideoRequest; end

        # Video context and/or feature-specific parameters.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::VideoSegment>]
        #     Video segments to annotate. The segments may overlap and are not required
        #     to be contiguous or span the whole video. If unspecified, each video is
        #     treated as a single segment.
        # @!attribute [rw] label_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::LabelDetectionConfig]
        #     Config for LABEL_DETECTION.
        # @!attribute [rw] shot_change_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::ShotChangeDetectionConfig]
        #     Config for SHOT_CHANGE_DETECTION.
        # @!attribute [rw] explicit_content_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::ExplicitContentDetectionConfig]
        #     Config for EXPLICIT_CONTENT_DETECTION.
        # @!attribute [rw] text_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::TextDetectionConfig]
        #     Config for TEXT_DETECTION.
        class VideoContext; end

        # Config for LABEL_DETECTION.
        # @!attribute [rw] label_detection_mode
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::LabelDetectionMode]
        #     What labels should be detected with LABEL_DETECTION, in addition to
        #     video-level labels or segment-level labels.
        #     If unspecified, defaults to `SHOT_MODE`.
        # @!attribute [rw] stationary_camera
        #   @return [true, false]
        #     Whether the video has been shot from a stationary (i.e. non-moving) camera.
        #     When set to true, might improve detection accuracy for moving objects.
        #     Should be used with `SHOT_AND_FRAME_MODE` enabled.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for label detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class LabelDetectionConfig; end

        # Config for SHOT_CHANGE_DETECTION.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for shot change detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class ShotChangeDetectionConfig; end

        # Config for EXPLICIT_CONTENT_DETECTION.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for explicit content detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class ExplicitContentDetectionConfig; end

        # Config for TEXT_DETECTION.
        # @!attribute [rw] language_hints
        #   @return [Array<String>]
        #     Language hint can be specified if the language to be detected is known a
        #     priori. It can increase the accuracy of the detection. Language hint must
        #     be language code in BCP-47 format.
        #
        #     Automatic language detection is performed if no hint is provided.
        class TextDetectionConfig; end

        # Video segment.
        # @!attribute [rw] start_time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video,
        #     corresponding to the start of the segment (inclusive).
        # @!attribute [rw] end_time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video,
        #     corresponding to the end of the segment (inclusive).
        class VideoSegment; end

        # Video segment level annotation results for label detection.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::VideoSegment]
        #     Video segment where a label was detected.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Confidence that the label is accurate. Range: [0, 1].
        class LabelSegment; end

        # Video frame level annotation results for label detection.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video, corresponding to the
        #     video frame for this location.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Confidence that the label is accurate. Range: [0, 1].
        class LabelFrame; end

        # Detected entity from video analysis.
        # @!attribute [rw] entity_id
        #   @return [String]
        #     Opaque entity ID. Some IDs may be available in
        #     [Google Knowledge Graph Search
        #     API](https://developers.google.com/knowledge-graph/).
        # @!attribute [rw] description
        #   @return [String]
        #     Textual description, e.g. `Fixed-gear bicycle`.
        # @!attribute [rw] language_code
        #   @return [String]
        #     Language code for `description` in BCP-47 format.
        class Entity; end

        # Label annotation.
        # @!attribute [rw] entity
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::Entity]
        #     Detected entity.
        # @!attribute [rw] category_entities
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::Entity>]
        #     Common categories for the detected entity.
        #     E.g. when the label is `Terrier` the category is likely `dog`. And in some
        #     cases there might be more than one categories e.g. `Terrier` could also be
        #     a `pet`.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::LabelSegment>]
        #     All video segments where a label was detected.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::LabelFrame>]
        #     All video frames where a label was detected.
        class LabelAnnotation; end

        # Video frame level annotation results for explicit content.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video, corresponding to the
        #     video frame for this location.
        # @!attribute [rw] pornography_likelihood
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::Likelihood]
        #     Likelihood of the pornography content..
        class ExplicitContentFrame; end

        # Explicit content annotation (based on per-frame visual signals only).
        # If no explicit content has been detected in a frame, no annotations are
        # present for that frame.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::ExplicitContentFrame>]
        #     All video frames where explicit content was detected.
        class ExplicitContentAnnotation; end

        # Normalized bounding box.
        # The normalized vertex coordinates are relative to the original image.
        # Range: [0, 1].
        # @!attribute [rw] left
        #   @return [Float]
        #     Left X coordinate.
        # @!attribute [rw] top
        #   @return [Float]
        #     Top Y coordinate.
        # @!attribute [rw] right
        #   @return [Float]
        #     Right X coordinate.
        # @!attribute [rw] bottom
        #   @return [Float]
        #     Bottom Y coordinate.
        class NormalizedBoundingBox; end

        # Annotation results for a single video.
        # @!attribute [rw] input_uri
        #   @return [String]
        #     Video file location in
        #     [Google Cloud Storage](https://cloud.google.com/storage/).
        # @!attribute [rw] segment_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::LabelAnnotation>]
        #     Label annotations on video level or user specified segment level.
        #     There is exactly one element for each unique label.
        # @!attribute [rw] shot_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::LabelAnnotation>]
        #     Label annotations on shot level.
        #     There is exactly one element for each unique label.
        # @!attribute [rw] frame_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::LabelAnnotation>]
        #     Label annotations on frame level.
        #     There is exactly one element for each unique label.
        # @!attribute [rw] shot_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::VideoSegment>]
        #     Shot annotations. Each shot is represented as a video segment.
        # @!attribute [rw] explicit_annotation
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::ExplicitContentAnnotation]
        #     Explicit content annotation.
        # @!attribute [rw] text_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::TextAnnotation>]
        #     OCR text detection and tracking.
        #     Annotations for list of detected text snippets. Each will have list of
        #     frame information associated with it.
        # @!attribute [rw] object_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::ObjectTrackingAnnotation>]
        #     Annotations for list of objects detected and tracked in video.
        # @!attribute [rw] error
        #   @return [Google::Rpc::Status]
        #     If set, indicates an error. Note that for a single `AnnotateVideoRequest`
        #     some videos may succeed and some may fail.
        class VideoAnnotationResults; end

        # Video annotation response. Included in the `response`
        # field of the `Operation` returned by the `GetOperation`
        # call of the `google::longrunning::Operations` service.
        # @!attribute [rw] annotation_results
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::VideoAnnotationResults>]
        #     Annotation results for all videos specified in `AnnotateVideoRequest`.
        class AnnotateVideoResponse; end

        # Annotation progress for a single video.
        # @!attribute [rw] input_uri
        #   @return [String]
        #     Video file location in
        #     [Google Cloud Storage](https://cloud.google.com/storage/).
        # @!attribute [rw] progress_percent
        #   @return [Integer]
        #     Approximate percentage processed thus far. Guaranteed to be
        #     100 when fully processed.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time when the request was received.
        # @!attribute [rw] update_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time of the most recent update.
        class VideoAnnotationProgress; end

        # Video annotation progress. Included in the `metadata`
        # field of the `Operation` returned by the `GetOperation`
        # call of the `google::longrunning::Operations` service.
        # @!attribute [rw] annotation_progress
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::VideoAnnotationProgress>]
        #     Progress metadata for all videos specified in `AnnotateVideoRequest`.
        class AnnotateVideoProgress; end

        # A vertex represents a 2D point in the image.
        # NOTE: the normalized vertex coordinates are relative to the original image
        # and range from 0 to 1.
        # @!attribute [rw] x
        #   @return [Float]
        #     X coordinate.
        # @!attribute [rw] y
        #   @return [Float]
        #     Y coordinate.
        class NormalizedVertex; end

        # Normalized bounding polygon for text (that might not be aligned with axis).
        # Contains list of the corner points in clockwise order starting from
        # top-left corner. For example, for a rectangular bounding box:
        # When the text is horizontal it might look like:
        #         0----1
        #         |    |
        #         3----2
        #
        # When it's clockwise rotated 180 degrees around the top-left corner it
        # becomes:
        #         2----3
        #         |    |
        #         1----0
        #
        # and the vertex order will still be (0, 1, 2, 3). Note that values can be less
        # than 0, or greater than 1 due to trignometric calculations for location of
        # the box.
        # @!attribute [rw] vertices
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::NormalizedVertex>]
        #     Normalized vertices of the bounding polygon.
        class NormalizedBoundingPoly; end

        # Video segment level annotation results for text detection.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::VideoSegment]
        #     Video segment where a text snippet was detected.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Confidence for the track of detected text. It is calculated as the highest
        #     over all frames where OCR detected text appears.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::TextFrame>]
        #     Information related to the frames where OCR detected text appears.
        class TextSegment; end

        # Video frame level annotation results for text annotation (OCR).
        # Contains information regarding timestamp and bounding box locations for the
        # frames containing detected OCR text snippets.
        # @!attribute [rw] rotated_bounding_box
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::NormalizedBoundingPoly]
        #     Bounding polygon of the detected text for this frame.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Timestamp of this frame.
        class TextFrame; end

        # Annotations related to one detected OCR text snippet. This will contain the
        # corresponding text, confidence value, and frame level information for each
        # detection.
        # @!attribute [rw] text
        #   @return [String]
        #     The detected text.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::TextSegment>]
        #     All video segments where OCR detected text appears.
        class TextAnnotation; end

        # Video frame level annotations for object detection and tracking. This field
        # stores per frame location, time offset, and confidence.
        # @!attribute [rw] normalized_bounding_box
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::NormalizedBoundingBox]
        #     The normalized bounding box location of this object track for the frame.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     The timestamp of the frame in microseconds.
        class ObjectTrackingFrame; end

        # Annotations corresponding to one tracked object.
        # @!attribute [rw] entity
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::Entity]
        #     Entity to specify the object category that this track is labeled as.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Object category's labeling confidence of this track.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1p2beta1::ObjectTrackingFrame>]
        #     Information corresponding to all frames where this object track appears.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1p2beta1::VideoSegment]
        #     Each object track corresponds to one video segment where it appears.
        class ObjectTrackingAnnotation; end

        # Video annotation feature.
        module Feature
          # Unspecified.
          FEATURE_UNSPECIFIED = 0

          # Label detection. Detect objects, such as dog or flower.
          LABEL_DETECTION = 1

          # Shot change detection.
          SHOT_CHANGE_DETECTION = 2

          # Explicit content detection.
          EXPLICIT_CONTENT_DETECTION = 3

          # OCR text detection and tracking.
          TEXT_DETECTION = 7

          # Object detection and tracking.
          OBJECT_TRACKING = 9
        end

        # Label detection mode.
        module LabelDetectionMode
          # Unspecified.
          LABEL_DETECTION_MODE_UNSPECIFIED = 0

          # Detect shot-level labels.
          SHOT_MODE = 1

          # Detect frame-level labels.
          FRAME_MODE = 2

          # Detect both shot-level and frame-level labels.
          SHOT_AND_FRAME_MODE = 3
        end

        # Bucketized representation of likelihood.
        module Likelihood
          # Unspecified likelihood.
          LIKELIHOOD_UNSPECIFIED = 0

          # Very unlikely.
          VERY_UNLIKELY = 1

          # Unlikely.
          UNLIKELY = 2

          # Possible.
          POSSIBLE = 3

          # Likely.
          LIKELY = 4

          # Very likely.
          VERY_LIKELY = 5
        end
      end
    end
  end
end