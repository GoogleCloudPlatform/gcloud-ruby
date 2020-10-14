# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/security/privateca/v1beta1/service.proto for package 'Google.Cloud.Security.PrivateCA.V1beta1'
# Original file comments:
# Copyright 2020 Google LLC
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
#

require 'grpc'
require 'google/cloud/security/privateca/v1beta1/service_pb'

module Google
  module Cloud
    module Security
      module PrivateCA
        module V1beta1
          module CertificateAuthorityService
            # [Certificate Authority Service][google.cloud.security.privateca.v1beta1.CertificateAuthorityService] manages private
            # certificate authorities and issued certificates.
            class Service

              include GRPC::GenericService

              self.marshal_class_method = :encode
              self.unmarshal_class_method = :decode
              self.service_name = 'google.cloud.security.privateca.v1beta1.CertificateAuthorityService'

              # Create a new [Certificate][google.cloud.security.privateca.v1beta1.Certificate] in a given Project, Location from a particular
              # [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority].
              rpc :CreateCertificate, ::Google::Cloud::Security::PrivateCA::V1beta1::CreateCertificateRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::Certificate
              # Returns a [Certificate][google.cloud.security.privateca.v1beta1.Certificate].
              rpc :GetCertificate, ::Google::Cloud::Security::PrivateCA::V1beta1::GetCertificateRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::Certificate
              # Lists [Certificates][google.cloud.security.privateca.v1beta1.Certificate].
              rpc :ListCertificates, ::Google::Cloud::Security::PrivateCA::V1beta1::ListCertificatesRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::ListCertificatesResponse
              # Revoke a [Certificate][google.cloud.security.privateca.v1beta1.Certificate].
              rpc :RevokeCertificate, ::Google::Cloud::Security::PrivateCA::V1beta1::RevokeCertificateRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::Certificate
              # Update a [Certificate][google.cloud.security.privateca.v1beta1.Certificate]. Currently, the only field you can update is the
              # [labels][google.cloud.security.privateca.v1beta1.Certificate.labels] field.
              rpc :UpdateCertificate, ::Google::Cloud::Security::PrivateCA::V1beta1::UpdateCertificateRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::Certificate
              # Activate a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority] that is in state
              # [PENDING_ACTIVATION][google.cloud.security.privateca.v1beta1.CertificateAuthority.State.PENDING_ACTIVATION] and is
              # of type [SUBORDINATE][google.cloud.security.privateca.v1beta1.CertificateAuthority.Type.SUBORDINATE]. After the
              # parent Certificate Authority signs a certificate signing request from
              # [FetchCertificateAuthorityCsr][google.cloud.security.privateca.v1beta1.CertificateAuthorityService.FetchCertificateAuthorityCsr], this method can complete the activation
              # process.
              rpc :ActivateCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::ActivateCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Create a new [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority] in a given Project and Location.
              rpc :CreateCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::CreateCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Disable a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority].
              rpc :DisableCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::DisableCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Enable a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority].
              rpc :EnableCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::EnableCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Fetch a certificate signing request (CSR) from a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority]
              # that is in state
              # [PENDING_ACTIVATION][google.cloud.security.privateca.v1beta1.CertificateAuthority.State.PENDING_ACTIVATION] and is
              # of type [SUBORDINATE][google.cloud.security.privateca.v1beta1.CertificateAuthority.Type.SUBORDINATE]. The CSR must
              # then be signed by the desired parent Certificate Authority, which could be
              # another [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority] resource, or could be an on-prem
              # certificate authority. See also [ActivateCertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthorityService.ActivateCertificateAuthority].
              rpc :FetchCertificateAuthorityCsr, ::Google::Cloud::Security::PrivateCA::V1beta1::FetchCertificateAuthorityCsrRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::FetchCertificateAuthorityCsrResponse
              # Returns a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority].
              rpc :GetCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::GetCertificateAuthorityRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::CertificateAuthority
              # Lists [CertificateAuthorities][google.cloud.security.privateca.v1beta1.CertificateAuthority].
              rpc :ListCertificateAuthorities, ::Google::Cloud::Security::PrivateCA::V1beta1::ListCertificateAuthoritiesRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::ListCertificateAuthoritiesResponse
              # Restore a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority] that is scheduled for deletion.
              rpc :RestoreCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::RestoreCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Schedule a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority] for deletion.
              rpc :ScheduleDeleteCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::ScheduleDeleteCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Update a [CertificateAuthority][google.cloud.security.privateca.v1beta1.CertificateAuthority].
              rpc :UpdateCertificateAuthority, ::Google::Cloud::Security::PrivateCA::V1beta1::UpdateCertificateAuthorityRequest, ::Google::Longrunning::Operation
              # Returns a [CertificateRevocationList][google.cloud.security.privateca.v1beta1.CertificateRevocationList].
              rpc :GetCertificateRevocationList, ::Google::Cloud::Security::PrivateCA::V1beta1::GetCertificateRevocationListRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::CertificateRevocationList
              # Lists [CertificateRevocationLists][google.cloud.security.privateca.v1beta1.CertificateRevocationList].
              rpc :ListCertificateRevocationLists, ::Google::Cloud::Security::PrivateCA::V1beta1::ListCertificateRevocationListsRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::ListCertificateRevocationListsResponse
              # Update a [CertificateRevocationList][google.cloud.security.privateca.v1beta1.CertificateRevocationList].
              rpc :UpdateCertificateRevocationList, ::Google::Cloud::Security::PrivateCA::V1beta1::UpdateCertificateRevocationListRequest, ::Google::Longrunning::Operation
              # Returns a [ReusableConfig][google.cloud.security.privateca.v1beta1.ReusableConfig].
              rpc :GetReusableConfig, ::Google::Cloud::Security::PrivateCA::V1beta1::GetReusableConfigRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::ReusableConfig
              # Lists [ReusableConfigs][google.cloud.security.privateca.v1beta1.ReusableConfig].
              rpc :ListReusableConfigs, ::Google::Cloud::Security::PrivateCA::V1beta1::ListReusableConfigsRequest, ::Google::Cloud::Security::PrivateCA::V1beta1::ListReusableConfigsResponse
            end

            Stub = Service.rpc_stub_class
          end
        end
      end
    end
  end
end
