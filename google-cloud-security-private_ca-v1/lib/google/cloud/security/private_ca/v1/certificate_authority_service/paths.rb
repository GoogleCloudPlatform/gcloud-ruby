# frozen_string_literal: true

# Copyright 2021 Google LLC
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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Cloud
    module Security
      module PrivateCA
        module V1
          module CertificateAuthorityService
            # Path helper methods for the CertificateAuthorityService API.
            module Paths
              ##
              # Create a fully-qualified CaPool resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/locations/{location}/caPools/{ca_pool}`
              #
              # @param project [String]
              # @param location [String]
              # @param ca_pool [String]
              #
              # @return [::String]
              def ca_pool_path project:, location:, ca_pool:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                raise ::ArgumentError, "location cannot contain /" if location.to_s.include? "/"

                "projects/#{project}/locations/#{location}/caPools/#{ca_pool}"
              end

              ##
              # Create a fully-qualified Certificate resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/locations/{location}/caPools/{ca_pool}/certificates/{certificate}`
              #
              # @param project [String]
              # @param location [String]
              # @param ca_pool [String]
              # @param certificate [String]
              #
              # @return [::String]
              def certificate_path project:, location:, ca_pool:, certificate:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                raise ::ArgumentError, "location cannot contain /" if location.to_s.include? "/"
                raise ::ArgumentError, "ca_pool cannot contain /" if ca_pool.to_s.include? "/"

                "projects/#{project}/locations/#{location}/caPools/#{ca_pool}/certificates/#{certificate}"
              end

              ##
              # Create a fully-qualified CertificateAuthority resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/locations/{location}/caPools/{ca_pool}/certificateAuthorities/{certificate_authority}`
              #
              # @param project [String]
              # @param location [String]
              # @param ca_pool [String]
              # @param certificate_authority [String]
              #
              # @return [::String]
              def certificate_authority_path project:, location:, ca_pool:, certificate_authority:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                raise ::ArgumentError, "location cannot contain /" if location.to_s.include? "/"
                raise ::ArgumentError, "ca_pool cannot contain /" if ca_pool.to_s.include? "/"

                "projects/#{project}/locations/#{location}/caPools/#{ca_pool}/certificateAuthorities/#{certificate_authority}"
              end

              ##
              # Create a fully-qualified CertificateRevocationList resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/locations/{location}/caPools/{ca_pool}/certificateAuthorities/{certificate_authority}/certificateRevocationLists/{certificate_revocation_list}`
              #
              # @param project [String]
              # @param location [String]
              # @param ca_pool [String]
              # @param certificate_authority [String]
              # @param certificate_revocation_list [String]
              #
              # @return [::String]
              def certificate_revocation_list_path project:, location:, ca_pool:, certificate_authority:, certificate_revocation_list:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                raise ::ArgumentError, "location cannot contain /" if location.to_s.include? "/"
                raise ::ArgumentError, "ca_pool cannot contain /" if ca_pool.to_s.include? "/"
                raise ::ArgumentError, "certificate_authority cannot contain /" if certificate_authority.to_s.include? "/"

                "projects/#{project}/locations/#{location}/caPools/#{ca_pool}/certificateAuthorities/#{certificate_authority}/certificateRevocationLists/#{certificate_revocation_list}"
              end

              ##
              # Create a fully-qualified CertificateTemplate resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/locations/{location}/certificateTemplates/{certificate_template}`
              #
              # @param project [String]
              # @param location [String]
              # @param certificate_template [String]
              #
              # @return [::String]
              def certificate_template_path project:, location:, certificate_template:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                raise ::ArgumentError, "location cannot contain /" if location.to_s.include? "/"

                "projects/#{project}/locations/#{location}/certificateTemplates/#{certificate_template}"
              end

              ##
              # Create a fully-qualified Location resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/locations/{location}`
              #
              # @param project [String]
              # @param location [String]
              #
              # @return [::String]
              def location_path project:, location:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"

                "projects/#{project}/locations/#{location}"
              end

              extend self
            end
          end
        end
      end
    end
  end
end