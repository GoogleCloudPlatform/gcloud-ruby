# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/container/v1/cluster_service.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/protobuf/empty_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.container.v1.NodeConfig" do
    optional :machine_type, :string, 1
    optional :disk_size_gb, :int32, 2
    repeated :oauth_scopes, :string, 3
    optional :service_account, :string, 9
    map :metadata, :string, :string, 4
    optional :image_type, :string, 5
    map :labels, :string, :string, 6
    optional :local_ssd_count, :int32, 7
    repeated :tags, :string, 8
    optional :preemptible, :bool, 10
    repeated :accelerators, :message, 11, "google.container.v1.AcceleratorConfig"
    optional :disk_type, :string, 12
    optional :min_cpu_platform, :string, 13
  end
  add_message "google.container.v1.MasterAuth" do
    optional :username, :string, 1
    optional :password, :string, 2
    optional :client_certificate_config, :message, 3, "google.container.v1.ClientCertificateConfig"
    optional :cluster_ca_certificate, :string, 100
    optional :client_certificate, :string, 101
    optional :client_key, :string, 102
  end
  add_message "google.container.v1.ClientCertificateConfig" do
    optional :issue_client_certificate, :bool, 1
  end
  add_message "google.container.v1.AddonsConfig" do
    optional :http_load_balancing, :message, 1, "google.container.v1.HttpLoadBalancing"
    optional :horizontal_pod_autoscaling, :message, 2, "google.container.v1.HorizontalPodAutoscaling"
    optional :kubernetes_dashboard, :message, 3, "google.container.v1.KubernetesDashboard"
    optional :network_policy_config, :message, 4, "google.container.v1.NetworkPolicyConfig"
  end
  add_message "google.container.v1.HttpLoadBalancing" do
    optional :disabled, :bool, 1
  end
  add_message "google.container.v1.HorizontalPodAutoscaling" do
    optional :disabled, :bool, 1
  end
  add_message "google.container.v1.KubernetesDashboard" do
    optional :disabled, :bool, 1
  end
  add_message "google.container.v1.NetworkPolicyConfig" do
    optional :disabled, :bool, 1
  end
  add_message "google.container.v1.MasterAuthorizedNetworksConfig" do
    optional :enabled, :bool, 1
    repeated :cidr_blocks, :message, 2, "google.container.v1.MasterAuthorizedNetworksConfig.CidrBlock"
  end
  add_message "google.container.v1.MasterAuthorizedNetworksConfig.CidrBlock" do
    optional :display_name, :string, 1
    optional :cidr_block, :string, 2
  end
  add_message "google.container.v1.LegacyAbac" do
    optional :enabled, :bool, 1
  end
  add_message "google.container.v1.NetworkPolicy" do
    optional :provider, :enum, 1, "google.container.v1.NetworkPolicy.Provider"
    optional :enabled, :bool, 2
  end
  add_enum "google.container.v1.NetworkPolicy.Provider" do
    value :PROVIDER_UNSPECIFIED, 0
    value :CALICO, 1
  end
  add_message "google.container.v1.IPAllocationPolicy" do
    optional :use_ip_aliases, :bool, 1
    optional :create_subnetwork, :bool, 2
    optional :subnetwork_name, :string, 3
    optional :cluster_ipv4_cidr, :string, 4
    optional :node_ipv4_cidr, :string, 5
    optional :services_ipv4_cidr, :string, 6
    optional :cluster_secondary_range_name, :string, 7
    optional :services_secondary_range_name, :string, 8
    optional :cluster_ipv4_cidr_block, :string, 9
    optional :node_ipv4_cidr_block, :string, 10
    optional :services_ipv4_cidr_block, :string, 11
  end
  add_message "google.container.v1.Cluster" do
    optional :name, :string, 1
    optional :description, :string, 2
    optional :initial_node_count, :int32, 3
    optional :node_config, :message, 4, "google.container.v1.NodeConfig"
    optional :master_auth, :message, 5, "google.container.v1.MasterAuth"
    optional :logging_service, :string, 6
    optional :monitoring_service, :string, 7
    optional :network, :string, 8
    optional :cluster_ipv4_cidr, :string, 9
    optional :addons_config, :message, 10, "google.container.v1.AddonsConfig"
    optional :subnetwork, :string, 11
    repeated :node_pools, :message, 12, "google.container.v1.NodePool"
    repeated :locations, :string, 13
    optional :enable_kubernetes_alpha, :bool, 14
    map :resource_labels, :string, :string, 15
    optional :label_fingerprint, :string, 16
    optional :legacy_abac, :message, 18, "google.container.v1.LegacyAbac"
    optional :network_policy, :message, 19, "google.container.v1.NetworkPolicy"
    optional :ip_allocation_policy, :message, 20, "google.container.v1.IPAllocationPolicy"
    optional :master_authorized_networks_config, :message, 22, "google.container.v1.MasterAuthorizedNetworksConfig"
    optional :maintenance_policy, :message, 23, "google.container.v1.MaintenancePolicy"
    optional :network_config, :message, 27, "google.container.v1.NetworkConfig"
    optional :self_link, :string, 100
    optional :zone, :string, 101
    optional :endpoint, :string, 102
    optional :initial_cluster_version, :string, 103
    optional :current_master_version, :string, 104
    optional :current_node_version, :string, 105
    optional :create_time, :string, 106
    optional :status, :enum, 107, "google.container.v1.Cluster.Status"
    optional :status_message, :string, 108
    optional :node_ipv4_cidr_size, :int32, 109
    optional :services_ipv4_cidr, :string, 110
    repeated :instance_group_urls, :string, 111
    optional :current_node_count, :int32, 112
    optional :expire_time, :string, 113
    optional :location, :string, 114
  end
  add_enum "google.container.v1.Cluster.Status" do
    value :STATUS_UNSPECIFIED, 0
    value :PROVISIONING, 1
    value :RUNNING, 2
    value :RECONCILING, 3
    value :STOPPING, 4
    value :ERROR, 5
    value :DEGRADED, 6
  end
  add_message "google.container.v1.ClusterUpdate" do
    optional :desired_node_version, :string, 4
    optional :desired_monitoring_service, :string, 5
    optional :desired_addons_config, :message, 6, "google.container.v1.AddonsConfig"
    optional :desired_node_pool_id, :string, 7
    optional :desired_image_type, :string, 8
    optional :desired_node_pool_autoscaling, :message, 9, "google.container.v1.NodePoolAutoscaling"
    repeated :desired_locations, :string, 10
    optional :desired_master_authorized_networks_config, :message, 12, "google.container.v1.MasterAuthorizedNetworksConfig"
    optional :desired_master_version, :string, 100
  end
  add_message "google.container.v1.Operation" do
    optional :name, :string, 1
    optional :zone, :string, 2
    optional :operation_type, :enum, 3, "google.container.v1.Operation.Type"
    optional :status, :enum, 4, "google.container.v1.Operation.Status"
    optional :detail, :string, 8
    optional :status_message, :string, 5
    optional :self_link, :string, 6
    optional :target_link, :string, 7
    optional :location, :string, 9
    optional :start_time, :string, 10
    optional :end_time, :string, 11
  end
  add_enum "google.container.v1.Operation.Status" do
    value :STATUS_UNSPECIFIED, 0
    value :PENDING, 1
    value :RUNNING, 2
    value :DONE, 3
    value :ABORTING, 4
  end
  add_enum "google.container.v1.Operation.Type" do
    value :TYPE_UNSPECIFIED, 0
    value :CREATE_CLUSTER, 1
    value :DELETE_CLUSTER, 2
    value :UPGRADE_MASTER, 3
    value :UPGRADE_NODES, 4
    value :REPAIR_CLUSTER, 5
    value :UPDATE_CLUSTER, 6
    value :CREATE_NODE_POOL, 7
    value :DELETE_NODE_POOL, 8
    value :SET_NODE_POOL_MANAGEMENT, 9
    value :AUTO_REPAIR_NODES, 10
    value :AUTO_UPGRADE_NODES, 11
    value :SET_LABELS, 12
    value :SET_MASTER_AUTH, 13
    value :SET_NODE_POOL_SIZE, 14
    value :SET_NETWORK_POLICY, 15
    value :SET_MAINTENANCE_POLICY, 16
  end
  add_message "google.container.v1.CreateClusterRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster, :message, 3, "google.container.v1.Cluster"
    optional :parent, :string, 5
  end
  add_message "google.container.v1.GetClusterRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :name, :string, 5
  end
  add_message "google.container.v1.UpdateClusterRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :update, :message, 4, "google.container.v1.ClusterUpdate"
    optional :name, :string, 5
  end
  add_message "google.container.v1.UpdateNodePoolRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :node_version, :string, 5
    optional :image_type, :string, 6
    optional :name, :string, 8
  end
  add_message "google.container.v1.SetNodePoolAutoscalingRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :autoscaling, :message, 5, "google.container.v1.NodePoolAutoscaling"
    optional :name, :string, 6
  end
  add_message "google.container.v1.SetLoggingServiceRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :logging_service, :string, 4
    optional :name, :string, 5
  end
  add_message "google.container.v1.SetMonitoringServiceRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :monitoring_service, :string, 4
    optional :name, :string, 6
  end
  add_message "google.container.v1.SetAddonsConfigRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :addons_config, :message, 4, "google.container.v1.AddonsConfig"
    optional :name, :string, 6
  end
  add_message "google.container.v1.SetLocationsRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    repeated :locations, :string, 4
    optional :name, :string, 6
  end
  add_message "google.container.v1.UpdateMasterRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :master_version, :string, 4
    optional :name, :string, 7
  end
  add_message "google.container.v1.SetMasterAuthRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :action, :enum, 4, "google.container.v1.SetMasterAuthRequest.Action"
    optional :update, :message, 5, "google.container.v1.MasterAuth"
    optional :name, :string, 7
  end
  add_enum "google.container.v1.SetMasterAuthRequest.Action" do
    value :UNKNOWN, 0
    value :SET_PASSWORD, 1
    value :GENERATE_PASSWORD, 2
    value :SET_USERNAME, 3
  end
  add_message "google.container.v1.DeleteClusterRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :name, :string, 4
  end
  add_message "google.container.v1.ListClustersRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :parent, :string, 4
  end
  add_message "google.container.v1.ListClustersResponse" do
    repeated :clusters, :message, 1, "google.container.v1.Cluster"
    repeated :missing_zones, :string, 2
  end
  add_message "google.container.v1.GetOperationRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :operation_id, :string, 3
    optional :name, :string, 5
  end
  add_message "google.container.v1.ListOperationsRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :parent, :string, 4
  end
  add_message "google.container.v1.CancelOperationRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :operation_id, :string, 3
    optional :name, :string, 4
  end
  add_message "google.container.v1.ListOperationsResponse" do
    repeated :operations, :message, 1, "google.container.v1.Operation"
    repeated :missing_zones, :string, 2
  end
  add_message "google.container.v1.GetServerConfigRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :name, :string, 4
  end
  add_message "google.container.v1.ServerConfig" do
    optional :default_cluster_version, :string, 1
    repeated :valid_node_versions, :string, 3
    optional :default_image_type, :string, 4
    repeated :valid_image_types, :string, 5
    repeated :valid_master_versions, :string, 6
  end
  add_message "google.container.v1.CreateNodePoolRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool, :message, 4, "google.container.v1.NodePool"
    optional :parent, :string, 6
  end
  add_message "google.container.v1.DeleteNodePoolRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :name, :string, 6
  end
  add_message "google.container.v1.ListNodePoolsRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :parent, :string, 5
  end
  add_message "google.container.v1.GetNodePoolRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :name, :string, 6
  end
  add_message "google.container.v1.NodePool" do
    optional :name, :string, 1
    optional :config, :message, 2, "google.container.v1.NodeConfig"
    optional :initial_node_count, :int32, 3
    optional :self_link, :string, 100
    optional :version, :string, 101
    repeated :instance_group_urls, :string, 102
    optional :status, :enum, 103, "google.container.v1.NodePool.Status"
    optional :status_message, :string, 104
    optional :autoscaling, :message, 4, "google.container.v1.NodePoolAutoscaling"
    optional :management, :message, 5, "google.container.v1.NodeManagement"
  end
  add_enum "google.container.v1.NodePool.Status" do
    value :STATUS_UNSPECIFIED, 0
    value :PROVISIONING, 1
    value :RUNNING, 2
    value :RUNNING_WITH_ERROR, 3
    value :RECONCILING, 4
    value :STOPPING, 5
    value :ERROR, 6
  end
  add_message "google.container.v1.NodeManagement" do
    optional :auto_upgrade, :bool, 1
    optional :auto_repair, :bool, 2
    optional :upgrade_options, :message, 10, "google.container.v1.AutoUpgradeOptions"
  end
  add_message "google.container.v1.AutoUpgradeOptions" do
    optional :auto_upgrade_start_time, :string, 1
    optional :description, :string, 2
  end
  add_message "google.container.v1.MaintenancePolicy" do
    optional :window, :message, 1, "google.container.v1.MaintenanceWindow"
  end
  add_message "google.container.v1.MaintenanceWindow" do
    oneof :policy do
      optional :daily_maintenance_window, :message, 2, "google.container.v1.DailyMaintenanceWindow"
    end
  end
  add_message "google.container.v1.DailyMaintenanceWindow" do
    optional :start_time, :string, 2
    optional :duration, :string, 3
  end
  add_message "google.container.v1.SetNodePoolManagementRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :management, :message, 5, "google.container.v1.NodeManagement"
    optional :name, :string, 7
  end
  add_message "google.container.v1.SetNodePoolSizeRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :node_count, :int32, 5
    optional :name, :string, 7
  end
  add_message "google.container.v1.RollbackNodePoolUpgradeRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :node_pool_id, :string, 4
    optional :name, :string, 6
  end
  add_message "google.container.v1.ListNodePoolsResponse" do
    repeated :node_pools, :message, 1, "google.container.v1.NodePool"
  end
  add_message "google.container.v1.NodePoolAutoscaling" do
    optional :enabled, :bool, 1
    optional :min_node_count, :int32, 2
    optional :max_node_count, :int32, 3
  end
  add_message "google.container.v1.SetLabelsRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    map :resource_labels, :string, :string, 4
    optional :label_fingerprint, :string, 5
    optional :name, :string, 7
  end
  add_message "google.container.v1.SetLegacyAbacRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :enabled, :bool, 4
    optional :name, :string, 6
  end
  add_message "google.container.v1.StartIPRotationRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :name, :string, 6
    optional :rotate_credentials, :bool, 7
  end
  add_message "google.container.v1.CompleteIPRotationRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :name, :string, 7
  end
  add_message "google.container.v1.AcceleratorConfig" do
    optional :accelerator_count, :int64, 1
    optional :accelerator_type, :string, 2
  end
  add_message "google.container.v1.SetNetworkPolicyRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :network_policy, :message, 4, "google.container.v1.NetworkPolicy"
    optional :name, :string, 6
  end
  add_message "google.container.v1.SetMaintenancePolicyRequest" do
    optional :project_id, :string, 1
    optional :zone, :string, 2
    optional :cluster_id, :string, 3
    optional :maintenance_policy, :message, 4, "google.container.v1.MaintenancePolicy"
    optional :name, :string, 5
  end
  add_message "google.container.v1.NetworkConfig" do
    optional :network, :string, 1
    optional :subnetwork, :string, 2
  end
end

module Google
  module Container
    module V1
      NodeConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NodeConfig").msgclass
      MasterAuth = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.MasterAuth").msgclass
      ClientCertificateConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ClientCertificateConfig").msgclass
      AddonsConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.AddonsConfig").msgclass
      HttpLoadBalancing = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.HttpLoadBalancing").msgclass
      HorizontalPodAutoscaling = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.HorizontalPodAutoscaling").msgclass
      KubernetesDashboard = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.KubernetesDashboard").msgclass
      NetworkPolicyConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NetworkPolicyConfig").msgclass
      MasterAuthorizedNetworksConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.MasterAuthorizedNetworksConfig").msgclass
      MasterAuthorizedNetworksConfig::CidrBlock = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.MasterAuthorizedNetworksConfig.CidrBlock").msgclass
      LegacyAbac = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.LegacyAbac").msgclass
      NetworkPolicy = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NetworkPolicy").msgclass
      NetworkPolicy::Provider = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NetworkPolicy.Provider").enummodule
      IPAllocationPolicy = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.IPAllocationPolicy").msgclass
      Cluster = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.Cluster").msgclass
      Cluster::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.Cluster.Status").enummodule
      ClusterUpdate = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ClusterUpdate").msgclass
      Operation = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.Operation").msgclass
      Operation::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.Operation.Status").enummodule
      Operation::Type = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.Operation.Type").enummodule
      CreateClusterRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.CreateClusterRequest").msgclass
      GetClusterRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.GetClusterRequest").msgclass
      UpdateClusterRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.UpdateClusterRequest").msgclass
      UpdateNodePoolRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.UpdateNodePoolRequest").msgclass
      SetNodePoolAutoscalingRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetNodePoolAutoscalingRequest").msgclass
      SetLoggingServiceRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetLoggingServiceRequest").msgclass
      SetMonitoringServiceRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetMonitoringServiceRequest").msgclass
      SetAddonsConfigRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetAddonsConfigRequest").msgclass
      SetLocationsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetLocationsRequest").msgclass
      UpdateMasterRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.UpdateMasterRequest").msgclass
      SetMasterAuthRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetMasterAuthRequest").msgclass
      SetMasterAuthRequest::Action = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetMasterAuthRequest.Action").enummodule
      DeleteClusterRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.DeleteClusterRequest").msgclass
      ListClustersRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ListClustersRequest").msgclass
      ListClustersResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ListClustersResponse").msgclass
      GetOperationRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.GetOperationRequest").msgclass
      ListOperationsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ListOperationsRequest").msgclass
      CancelOperationRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.CancelOperationRequest").msgclass
      ListOperationsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ListOperationsResponse").msgclass
      GetServerConfigRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.GetServerConfigRequest").msgclass
      ServerConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ServerConfig").msgclass
      CreateNodePoolRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.CreateNodePoolRequest").msgclass
      DeleteNodePoolRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.DeleteNodePoolRequest").msgclass
      ListNodePoolsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ListNodePoolsRequest").msgclass
      GetNodePoolRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.GetNodePoolRequest").msgclass
      NodePool = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NodePool").msgclass
      NodePool::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NodePool.Status").enummodule
      NodeManagement = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NodeManagement").msgclass
      AutoUpgradeOptions = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.AutoUpgradeOptions").msgclass
      MaintenancePolicy = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.MaintenancePolicy").msgclass
      MaintenanceWindow = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.MaintenanceWindow").msgclass
      DailyMaintenanceWindow = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.DailyMaintenanceWindow").msgclass
      SetNodePoolManagementRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetNodePoolManagementRequest").msgclass
      SetNodePoolSizeRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetNodePoolSizeRequest").msgclass
      RollbackNodePoolUpgradeRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.RollbackNodePoolUpgradeRequest").msgclass
      ListNodePoolsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.ListNodePoolsResponse").msgclass
      NodePoolAutoscaling = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NodePoolAutoscaling").msgclass
      SetLabelsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetLabelsRequest").msgclass
      SetLegacyAbacRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetLegacyAbacRequest").msgclass
      StartIPRotationRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.StartIPRotationRequest").msgclass
      CompleteIPRotationRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.CompleteIPRotationRequest").msgclass
      AcceleratorConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.AcceleratorConfig").msgclass
      SetNetworkPolicyRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetNetworkPolicyRequest").msgclass
      SetMaintenancePolicyRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.SetMaintenancePolicyRequest").msgclass
      NetworkConfig = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.container.v1.NetworkConfig").msgclass
    end
  end
end
