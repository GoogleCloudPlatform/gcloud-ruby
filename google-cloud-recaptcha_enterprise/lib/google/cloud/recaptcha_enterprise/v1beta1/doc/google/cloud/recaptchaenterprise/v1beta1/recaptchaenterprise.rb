# Copyright 2019 Google LLC
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
    module Recaptchaenterprise
      module V1beta1
        # The create assessment request message.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The name of the project in which the assessment will be created,
        #     in the format "projects/\\{project_number}".
        # @!attribute [rw] assessment
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::Assessment]
        #     Required. The assessment details.
        class CreateAssessmentRequest; end

        # The request message to annotate an Assessment.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the Assessment, in the format
        #     "projects/\\{project_number}/assessments/\\{assessment_id}".
        # @!attribute [rw] annotation
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::AnnotateAssessmentRequest::Annotation]
        #     Required. The annotation that will be assigned to the Event.
        class AnnotateAssessmentRequest
          # Enum that reprensents the types of annotations.
          module Annotation
            # Default unspecified type.
            ANNOTATION_UNSPECIFIED = 0

            # Provides information that the event turned out to be legitimate.
            LEGITIMATE = 1

            # Provides information that the event turned out to be fraudulent.
            FRAUDULENT = 2
          end
        end

        # Empty response for AnnotateAssessment.
        class AnnotateAssessmentResponse; end

        # A recaptcha assessment resource.
        # @!attribute [rw] name
        #   @return [String]
        #     Output only. The resource name for the Assessment in the format
        #     "projects/\\{project_number}/assessments/\\{assessment_id}".
        # @!attribute [rw] event
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::Event]
        #     The event being assessed.
        # @!attribute [rw] score
        #   @return [Float]
        #     Output only. Legitimate event score from 0.0 to 1.0.
        #     (1.0 means very likely legitimate traffic while 0.0 means very likely
        #     non-legitimate traffic).
        # @!attribute [rw] token_properties
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::TokenProperties]
        #     Output only. Properties of the provided event token.
        # @!attribute [rw] reasons
        #   @return [Array<Google::Cloud::Recaptchaenterprise::V1beta1::Assessment::ClassificationReason>]
        #     Output only. Reasons contributing to the risk analysis verdict.
        class Assessment
          # LINT.IfChange(classification_reason)
          # Reasons contributing to the risk analysis verdict.
          module ClassificationReason
            # Default unspecified type.
            CLASSIFICATION_REASON_UNSPECIFIED = 0

            # Interactions matched the behavior of an automated agent.
            AUTOMATION = 1

            # The event originated from an illegitimate environment.
            UNEXPECTED_ENVIRONMENT = 2

            # Traffic volume from the event source is higher than normal.
            TOO_MUCH_TRAFFIC = 3

            # Interactions with the site were significantly different than expected
            # patterns.
            UNEXPECTED_USAGE_PATTERNS = 4

            # Too little traffic has been received from this site thus far to generate
            # quality risk analysis.
            LOW_CONFIDENCE_SCORE = 5
          end
        end

        # @!attribute [rw] token
        #   @return [String]
        #     Optional. The user response token provided by the reCAPTCHA client-side integration
        #     on your site.
        # @!attribute [rw] site_key
        #   @return [String]
        #     Optional. The site key that was used to invoke reCAPTCHA on your site and generate
        #     the token.
        # @!attribute [rw] user_agent
        #   @return [String]
        #     Optional. The user agent present in the request from the user's device related to
        #     this event.
        # @!attribute [rw] user_ip_address
        #   @return [String]
        #     Optional. The IP address in the request from the user's device related to this event.
        # @!attribute [rw] expected_action
        #   @return [String]
        #     Optional. The expected action for this type of event. This should be the same action
        #     provided at token generation time on client-side platforms already
        #     integrated with recaptcha enterprise.
        class Event; end

        # @!attribute [rw] valid
        #   @return [true, false]
        #     Whether the provided user response token is valid.
        # @!attribute [rw] invalid_reason
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::TokenProperties::InvalidReason]
        #     Reason associated with the response when valid = false.
        # @!attribute [rw] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     The timestamp corresponding to the generation of the token.
        # @!attribute [rw] hostname
        #   @return [String]
        #     The hostname of the page on which the token was generated.
        # @!attribute [rw] action
        #   @return [String]
        #     Action name provided at token generation.
        class TokenProperties
          # LINT.IfChange
          # Enum that represents the types of invalid token reasons.
          module InvalidReason
            # Default unspecified type.
            INVALID_REASON_UNSPECIFIED = 0

            # If the failure reason was not accounted for.
            UNKNOWN_INVALID_REASON = 1

            # The provided user verification token was malformed.
            MALFORMED = 2

            # The user verification token had expired.
            EXPIRED = 3

            # The user verification had already been seen.
            DUPE = 4

            # The user verification token did not match the provided site key.
            # This may be a configuration error (e.g. development keys used in
            # production) or end users trying to use verification tokens from other
            # sites.
            SITE_MISMATCH = 5

            # The user verification token was not present.  It is a required input.
            MISSING = 6
          end
        end

        # The create key request message.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The name of the project in which the key will be created, in the
        #     format "projects/\\{project_number}".
        # @!attribute [rw] key
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::Key]
        #     Required. Information to create a reCAPTCHA Enterprise key.
        class CreateKeyRequest; end

        # The list keys request message.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The name of the project that contains the keys that will be
        #     listed, in the format "projects/\\{project_number}".
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     Optional. The maximum number of keys to return. Default is 10. Max limit is
        #     1000.
        # @!attribute [rw] page_token
        #   @return [String]
        #     Optional. The next_page_token value returned from a previous.
        #     ListKeysRequest, if any.
        class ListKeysRequest; end

        # Response to request to list keys in a project.
        # @!attribute [rw] keys
        #   @return [Array<Google::Cloud::Recaptchaenterprise::V1beta1::Key>]
        #     Key details.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     Token to retrieve the next page of results. It is set to empty if no keys
        #     remain in results.
        class ListKeysResponse; end

        # The get key request message.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The name of the requested key, in the format
        #     "projects/\\{project_number}/keys/\\{key_id}".
        class GetKeyRequest; end

        # The update key request message.
        # @!attribute [rw] key
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::Key]
        #     Required. The key to update.
        # @!attribute [rw] update_mask
        #   @return [Google::Protobuf::FieldMask]
        #     Optional. The mask to control which field of the key get updated. If the mask is not
        #     present, all fields will be updated.
        class UpdateKeyRequest; end

        # The delete key request message.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The name of the key to be deleted, in the format
        #     "projects/\\{project_number}/keys/\\{key_id}".
        class DeleteKeyRequest; end

        # A key used to identify and configure applications (web and/or mobile) that
        # use reCAPTCHA Enterprise.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name for the Key in the format
        #     "projects/\\{project_number}/keys/\\{key_id}".
        # @!attribute [rw] display_name
        #   @return [String]
        #     Human-readable display name of this key. Modifiable by user.
        # @!attribute [rw] web_settings
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::WebKeySettings]
        #     Settings for keys that can be used by websites.
        # @!attribute [rw] android_settings
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::AndroidKeySettings]
        #     Settings for keys that can be used by Android apps.
        # @!attribute [rw] ios_settings
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::IOSKeySettings]
        #     Settings for keys that can be used by iOS apps.
        class Key; end

        # Settings specific to keys that can be used by websites.
        # @!attribute [rw] enforce_allowed_domains
        #   @return [true, false]
        #     Whether allowed_domains is enforced or not.
        # @!attribute [rw] allowed_domains
        #   @return [Array<String>]
        #     Domains or subdomains of websites allowed to use the key. All subdomains
        #     of an allowed domain are automatically allowed. A valid domain requires a
        #     host and must not include any path, port, query or fragment.
        #     Examples: 'example.com' or 'subdomain.example.com'
        # @!attribute [rw] allow_amp_traffic
        #   @return [true, false]
        #     Whether this key can be used on AMP (Accelerated Mobile Pages) websites.
        # @!attribute [rw] integration_type
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::WebKeySettings::IntegrationType]
        #     Required. Describes how this key is integrated with the website.
        # @!attribute [rw] challenge_security_preference
        #   @return [Google::Cloud::Recaptchaenterprise::V1beta1::WebKeySettings::ChallengeSecurityPreference]
        #     Settings for the frequency and difficulty at which this key triggers
        #     captcha challenges. This should only be specified for IntegrationTypes
        #     CHECKBOX_CHALLENGE and INVISIBLE_CHALLENGE.
        class WebKeySettings
          # Enum that represents the possible challenge frequency and difficulty
          # configurations for a web key.
          module ChallengeSecurityPreference
            # Default type that indicates this enum hasn't been specified.
            CHALLENGE_SECURITY_PREFERENCE_UNSPECIFIED = 0

            # Key tends to show fewer and easier challenges.
            USABILITY = 1

            # Key tends to show balanced (in amount and difficulty) challenges.
            BALANCED = 2

            # Key tends to show more and harder challenges.
            SECURITY = 3
          end

          # Enum that represents the integration types for web keys.
          module IntegrationType
            # Default type that indicates this enum hasn't been specified. This is not
            # a valid IntegrationType, one of the other types must be specified
            # instead.
            INTEGRATION_TYPE_UNSPECIFIED = 0

            # Only used to produce scores. It doesn't display the "I'm not a robot"
            # checkbox and never shows captcha challenges.
            SCORE_ONLY = 1

            # Displays the "I'm not a robot" checkbox and may show captcha challenges
            # after it is checked.
            CHECKBOX_CHALLENGE = 2

            # Doesn't display the "I'm not a robot" checkbox, but may show captcha
            # challenges after risk analysis.
            INVISIBLE_CHALLENGE = 3
          end
        end

        # Settings specific to keys that can be used by Android apps.
        # @!attribute [rw] allowed_package_names
        #   @return [Array<String>]
        #     Android package names of apps allowed to use the key.
        #     Example: 'com.companyname.appname'
        class AndroidKeySettings; end

        # Settings specific to keys that can be used by iOS apps.
        # @!attribute [rw] allowed_bundle_ids
        #   @return [Array<String>]
        #     iOS bundle ids of apps allowed to use the key.
        #     Example: 'com.companyname.productname.appname'
        class IOSKeySettings; end
      end
    end
  end
end