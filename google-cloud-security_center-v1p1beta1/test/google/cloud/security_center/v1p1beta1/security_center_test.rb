# frozen_string_literal: true

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

require "simplecov"
require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/cloud/securitycenter/v1p1beta1/securitycenter_service_pb"
require "google/cloud/securitycenter/v1p1beta1/securitycenter_service_services_pb"
require "google/cloud/security_center/v1p1beta1/security_center"

class Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_create_source
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::Source.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    source = {}

    create_source_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_source, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::CreateSourceRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::Source), request.source
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_source_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_source({ parent: parent, source: source }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_source parent: parent, source: source do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_source Google::Cloud::SecurityCenter::V1p1beta1::CreateSourceRequest.new(parent: parent, source: source) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_source({ parent: parent, source: source }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_source Google::Cloud::SecurityCenter::V1p1beta1::CreateSourceRequest.new(parent: parent, source: source), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_source_client_stub.call_rpc_count
    end
  end

  def test_create_finding
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::Finding.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    finding_id = "hello world"
    finding = {}

    create_finding_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_finding, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::CreateFindingRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.finding_id
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::Finding), request.finding
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_finding_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_finding({ parent: parent, finding_id: finding_id, finding: finding }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_finding parent: parent, finding_id: finding_id, finding: finding do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_finding Google::Cloud::SecurityCenter::V1p1beta1::CreateFindingRequest.new(parent: parent, finding_id: finding_id, finding: finding) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_finding({ parent: parent, finding_id: finding_id, finding: finding }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_finding Google::Cloud::SecurityCenter::V1p1beta1::CreateFindingRequest.new(parent: parent, finding_id: finding_id, finding: finding), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_finding_client_stub.call_rpc_count
    end
  end

  def test_create_notification_config
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    config_id = "hello world"
    notification_config = {}

    create_notification_config_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_notification_config, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::CreateNotificationConfigRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.config_id
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig), request.notification_config
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_notification_config_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_notification_config({ parent: parent, config_id: config_id, notification_config: notification_config }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_notification_config parent: parent, config_id: config_id, notification_config: notification_config do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_notification_config Google::Cloud::SecurityCenter::V1p1beta1::CreateNotificationConfigRequest.new(parent: parent, config_id: config_id, notification_config: notification_config) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_notification_config({ parent: parent, config_id: config_id, notification_config: notification_config }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_notification_config Google::Cloud::SecurityCenter::V1p1beta1::CreateNotificationConfigRequest.new(parent: parent, config_id: config_id, notification_config: notification_config), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_notification_config_client_stub.call_rpc_count
    end
  end

  def test_delete_notification_config
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_notification_config_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_notification_config, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::DeleteNotificationConfigRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_notification_config_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_notification_config({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_notification_config name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_notification_config Google::Cloud::SecurityCenter::V1p1beta1::DeleteNotificationConfigRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_notification_config({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_notification_config Google::Cloud::SecurityCenter::V1p1beta1::DeleteNotificationConfigRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_notification_config_client_stub.call_rpc_count
    end
  end

  def test_get_iam_policy
    # Create GRPC objects.
    grpc_response = Google::Iam::V1::Policy.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    options = {}

    get_iam_policy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_iam_policy, name
      assert_kind_of Google::Iam::V1::GetIamPolicyRequest, request
      assert_equal "hello world", request.resource
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Iam::V1::GetPolicyOptions), request.options
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_iam_policy_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_iam_policy({ resource: resource, options: options }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_iam_policy resource: resource, options: options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_iam_policy Google::Iam::V1::GetIamPolicyRequest.new(resource: resource, options: options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_iam_policy({ resource: resource, options: options }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_iam_policy Google::Iam::V1::GetIamPolicyRequest.new(resource: resource, options: options), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_iam_policy_client_stub.call_rpc_count
    end
  end

  def test_get_notification_config
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_notification_config_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_notification_config, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::GetNotificationConfigRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_notification_config_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_notification_config({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_notification_config name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_notification_config Google::Cloud::SecurityCenter::V1p1beta1::GetNotificationConfigRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_notification_config({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_notification_config Google::Cloud::SecurityCenter::V1p1beta1::GetNotificationConfigRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_notification_config_client_stub.call_rpc_count
    end
  end

  def test_get_organization_settings
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::OrganizationSettings.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_organization_settings_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_organization_settings, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::GetOrganizationSettingsRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_organization_settings_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_organization_settings({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_organization_settings name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_organization_settings Google::Cloud::SecurityCenter::V1p1beta1::GetOrganizationSettingsRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_organization_settings({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_organization_settings Google::Cloud::SecurityCenter::V1p1beta1::GetOrganizationSettingsRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_organization_settings_client_stub.call_rpc_count
    end
  end

  def test_get_source
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::Source.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_source_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_source, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::GetSourceRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_source_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_source({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_source name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_source Google::Cloud::SecurityCenter::V1p1beta1::GetSourceRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_source({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_source Google::Cloud::SecurityCenter::V1p1beta1::GetSourceRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_source_client_stub.call_rpc_count
    end
  end

  def test_group_assets
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::GroupAssetsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    group_by = "hello world"
    compare_duration = {}
    read_time = {}
    having = "hello world"
    page_token = "hello world"
    page_size = 42

    group_assets_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :group_assets, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::GroupAssetsRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.group_by
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.compare_duration
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.read_time
      assert_equal "hello world", request.having
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, group_assets_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.group_assets({ parent: parent, filter: filter, group_by: group_by, compare_duration: compare_duration, read_time: read_time, having: having, page_token: page_token, page_size: page_size }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.group_assets parent: parent, filter: filter, group_by: group_by, compare_duration: compare_duration, read_time: read_time, having: having, page_token: page_token, page_size: page_size do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.group_assets Google::Cloud::SecurityCenter::V1p1beta1::GroupAssetsRequest.new(parent: parent, filter: filter, group_by: group_by, compare_duration: compare_duration, read_time: read_time, having: having, page_token: page_token, page_size: page_size) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.group_assets({ parent: parent, filter: filter, group_by: group_by, compare_duration: compare_duration, read_time: read_time, having: having, page_token: page_token, page_size: page_size }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.group_assets Google::Cloud::SecurityCenter::V1p1beta1::GroupAssetsRequest.new(parent: parent, filter: filter, group_by: group_by, compare_duration: compare_duration, read_time: read_time, having: having, page_token: page_token, page_size: page_size), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, group_assets_client_stub.call_rpc_count
    end
  end

  def test_group_findings
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::GroupFindingsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    group_by = "hello world"
    read_time = {}
    compare_duration = {}
    having = "hello world"
    page_token = "hello world"
    page_size = 42

    group_findings_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :group_findings, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::GroupFindingsRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.group_by
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.read_time
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.compare_duration
      assert_equal "hello world", request.having
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, group_findings_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.group_findings({ parent: parent, filter: filter, group_by: group_by, read_time: read_time, compare_duration: compare_duration, having: having, page_token: page_token, page_size: page_size }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.group_findings parent: parent, filter: filter, group_by: group_by, read_time: read_time, compare_duration: compare_duration, having: having, page_token: page_token, page_size: page_size do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.group_findings Google::Cloud::SecurityCenter::V1p1beta1::GroupFindingsRequest.new(parent: parent, filter: filter, group_by: group_by, read_time: read_time, compare_duration: compare_duration, having: having, page_token: page_token, page_size: page_size) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.group_findings({ parent: parent, filter: filter, group_by: group_by, read_time: read_time, compare_duration: compare_duration, having: having, page_token: page_token, page_size: page_size }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.group_findings Google::Cloud::SecurityCenter::V1p1beta1::GroupFindingsRequest.new(parent: parent, filter: filter, group_by: group_by, read_time: read_time, compare_duration: compare_duration, having: having, page_token: page_token, page_size: page_size), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, group_findings_client_stub.call_rpc_count
    end
  end

  def test_list_assets
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::ListAssetsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    order_by = "hello world"
    read_time = {}
    compare_duration = {}
    having = "hello world"
    field_mask = {}
    page_token = "hello world"
    page_size = 42

    list_assets_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_assets, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::ListAssetsRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.order_by
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.read_time
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.compare_duration
      assert_equal "hello world", request.having
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.field_mask
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_assets_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_assets({ parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_assets parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_assets Google::Cloud::SecurityCenter::V1p1beta1::ListAssetsRequest.new(parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_assets({ parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_assets Google::Cloud::SecurityCenter::V1p1beta1::ListAssetsRequest.new(parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_assets_client_stub.call_rpc_count
    end
  end

  def test_list_findings
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::ListFindingsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    order_by = "hello world"
    read_time = {}
    compare_duration = {}
    having = "hello world"
    field_mask = {}
    page_token = "hello world"
    page_size = 42

    list_findings_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_findings, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::ListFindingsRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.order_by
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.read_time
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.compare_duration
      assert_equal "hello world", request.having
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.field_mask
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_findings_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_findings({ parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_findings parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_findings Google::Cloud::SecurityCenter::V1p1beta1::ListFindingsRequest.new(parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_findings({ parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_findings Google::Cloud::SecurityCenter::V1p1beta1::ListFindingsRequest.new(parent: parent, filter: filter, order_by: order_by, read_time: read_time, compare_duration: compare_duration, having: having, field_mask: field_mask, page_token: page_token, page_size: page_size), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_findings_client_stub.call_rpc_count
    end
  end

  def test_list_notification_configs
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::ListNotificationConfigsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42

    list_notification_configs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_notification_configs, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::ListNotificationConfigsRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_notification_configs_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_notification_configs({ parent: parent, page_token: page_token, page_size: page_size }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_notification_configs parent: parent, page_token: page_token, page_size: page_size do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_notification_configs Google::Cloud::SecurityCenter::V1p1beta1::ListNotificationConfigsRequest.new(parent: parent, page_token: page_token, page_size: page_size) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_notification_configs({ parent: parent, page_token: page_token, page_size: page_size }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_notification_configs Google::Cloud::SecurityCenter::V1p1beta1::ListNotificationConfigsRequest.new(parent: parent, page_token: page_token, page_size: page_size), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_notification_configs_client_stub.call_rpc_count
    end
  end

  def test_list_sources
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::ListSourcesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42

    list_sources_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_sources, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::ListSourcesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_sources_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_sources({ parent: parent, page_token: page_token, page_size: page_size }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_sources parent: parent, page_token: page_token, page_size: page_size do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_sources Google::Cloud::SecurityCenter::V1p1beta1::ListSourcesRequest.new(parent: parent, page_token: page_token, page_size: page_size) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_sources({ parent: parent, page_token: page_token, page_size: page_size }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_sources Google::Cloud::SecurityCenter::V1p1beta1::ListSourcesRequest.new(parent: parent, page_token: page_token, page_size: page_size), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_sources_client_stub.call_rpc_count
    end
  end

  def test_run_asset_discovery
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"

    run_asset_discovery_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :run_asset_discovery, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::RunAssetDiscoveryRequest, request
      assert_equal "hello world", request.parent
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, run_asset_discovery_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.run_asset_discovery({ parent: parent }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.run_asset_discovery parent: parent do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.run_asset_discovery Google::Cloud::SecurityCenter::V1p1beta1::RunAssetDiscoveryRequest.new(parent: parent) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.run_asset_discovery({ parent: parent }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.run_asset_discovery Google::Cloud::SecurityCenter::V1p1beta1::RunAssetDiscoveryRequest.new(parent: parent), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, run_asset_discovery_client_stub.call_rpc_count
    end
  end

  def test_set_finding_state
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::Finding.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    state = :STATE_UNSPECIFIED
    start_time = {}

    set_finding_state_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :set_finding_state, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::SetFindingStateRequest, request
      assert_equal "hello world", request.name
      assert_equal :STATE_UNSPECIFIED, request.state
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.start_time
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, set_finding_state_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.set_finding_state({ name: name, state: state, start_time: start_time }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.set_finding_state name: name, state: state, start_time: start_time do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.set_finding_state Google::Cloud::SecurityCenter::V1p1beta1::SetFindingStateRequest.new(name: name, state: state, start_time: start_time) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.set_finding_state({ name: name, state: state, start_time: start_time }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.set_finding_state Google::Cloud::SecurityCenter::V1p1beta1::SetFindingStateRequest.new(name: name, state: state, start_time: start_time), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, set_finding_state_client_stub.call_rpc_count
    end
  end

  def test_set_iam_policy
    # Create GRPC objects.
    grpc_response = Google::Iam::V1::Policy.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    policy = {}

    set_iam_policy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :set_iam_policy, name
      assert_kind_of Google::Iam::V1::SetIamPolicyRequest, request
      assert_equal "hello world", request.resource
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Iam::V1::Policy), request.policy
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, set_iam_policy_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.set_iam_policy({ resource: resource, policy: policy }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.set_iam_policy resource: resource, policy: policy do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.set_iam_policy Google::Iam::V1::SetIamPolicyRequest.new(resource: resource, policy: policy) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.set_iam_policy({ resource: resource, policy: policy }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.set_iam_policy Google::Iam::V1::SetIamPolicyRequest.new(resource: resource, policy: policy), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, set_iam_policy_client_stub.call_rpc_count
    end
  end

  def test_test_iam_permissions
    # Create GRPC objects.
    grpc_response = Google::Iam::V1::TestIamPermissionsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    permissions = ["hello world"]

    test_iam_permissions_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :test_iam_permissions, name
      assert_kind_of Google::Iam::V1::TestIamPermissionsRequest, request
      assert_equal "hello world", request.resource
      assert_equal ["hello world"], request.permissions
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, test_iam_permissions_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.test_iam_permissions({ resource: resource, permissions: permissions }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.test_iam_permissions resource: resource, permissions: permissions do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.test_iam_permissions Google::Iam::V1::TestIamPermissionsRequest.new(resource: resource, permissions: permissions) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.test_iam_permissions({ resource: resource, permissions: permissions }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.test_iam_permissions Google::Iam::V1::TestIamPermissionsRequest.new(resource: resource, permissions: permissions), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, test_iam_permissions_client_stub.call_rpc_count
    end
  end

  def test_update_finding
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::Finding.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    finding = {}
    update_mask = {}

    update_finding_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_finding, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::UpdateFindingRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::Finding), request.finding
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_finding_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_finding({ finding: finding, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_finding finding: finding, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_finding Google::Cloud::SecurityCenter::V1p1beta1::UpdateFindingRequest.new(finding: finding, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_finding({ finding: finding, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_finding Google::Cloud::SecurityCenter::V1p1beta1::UpdateFindingRequest.new(finding: finding, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_finding_client_stub.call_rpc_count
    end
  end

  def test_update_notification_config
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    notification_config = {}
    update_mask = {}

    update_notification_config_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_notification_config, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::UpdateNotificationConfigRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig), request.notification_config
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_notification_config_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_notification_config({ notification_config: notification_config, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_notification_config notification_config: notification_config, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_notification_config Google::Cloud::SecurityCenter::V1p1beta1::UpdateNotificationConfigRequest.new(notification_config: notification_config, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_notification_config({ notification_config: notification_config, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_notification_config Google::Cloud::SecurityCenter::V1p1beta1::UpdateNotificationConfigRequest.new(notification_config: notification_config, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_notification_config_client_stub.call_rpc_count
    end
  end

  def test_update_organization_settings
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::OrganizationSettings.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    organization_settings = {}
    update_mask = {}

    update_organization_settings_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_organization_settings, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::UpdateOrganizationSettingsRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::OrganizationSettings), request.organization_settings
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_organization_settings_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_organization_settings({ organization_settings: organization_settings, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_organization_settings organization_settings: organization_settings, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_organization_settings Google::Cloud::SecurityCenter::V1p1beta1::UpdateOrganizationSettingsRequest.new(organization_settings: organization_settings, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_organization_settings({ organization_settings: organization_settings, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_organization_settings Google::Cloud::SecurityCenter::V1p1beta1::UpdateOrganizationSettingsRequest.new(organization_settings: organization_settings, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_organization_settings_client_stub.call_rpc_count
    end
  end

  def test_update_source
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::Source.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    source = {}
    update_mask = {}

    update_source_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_source, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::UpdateSourceRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::Source), request.source
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_source_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_source({ source: source, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_source source: source, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_source Google::Cloud::SecurityCenter::V1p1beta1::UpdateSourceRequest.new(source: source, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_source({ source: source, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_source Google::Cloud::SecurityCenter::V1p1beta1::UpdateSourceRequest.new(source: source, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_source_client_stub.call_rpc_count
    end
  end

  def test_update_security_marks
    # Create GRPC objects.
    grpc_response = Google::Cloud::SecurityCenter::V1p1beta1::SecurityMarks.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    security_marks = {}
    update_mask = {}
    start_time = {}

    update_security_marks_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_security_marks, name
      assert_kind_of Google::Cloud::SecurityCenter::V1p1beta1::UpdateSecurityMarksRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::SecurityCenter::V1p1beta1::SecurityMarks), request.security_marks
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.start_time
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_security_marks_client_stub do
      # Create client
      client = Google::Cloud::SecurityCenter::V1p1beta1::SecurityCenter::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_security_marks({ security_marks: security_marks, update_mask: update_mask, start_time: start_time }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_security_marks security_marks: security_marks, update_mask: update_mask, start_time: start_time do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_security_marks Google::Cloud::SecurityCenter::V1p1beta1::UpdateSecurityMarksRequest.new(security_marks: security_marks, update_mask: update_mask, start_time: start_time) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_security_marks({ security_marks: security_marks, update_mask: update_mask, start_time: start_time }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_security_marks Google::Cloud::SecurityCenter::V1p1beta1::UpdateSecurityMarksRequest.new(security_marks: security_marks, update_mask: update_mask, start_time: start_time), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_security_marks_client_stub.call_rpc_count
    end
  end
end
