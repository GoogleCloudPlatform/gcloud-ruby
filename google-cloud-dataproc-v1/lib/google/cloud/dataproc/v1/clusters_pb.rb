# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/dataproc/v1/clusters.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/cloud/dataproc/v1/shared_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/duration_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/dataproc/v1/clusters.proto", :syntax => :proto3) do
    add_message "google.cloud.dataproc.v1.Cluster" do
      optional :project_id, :string, 1
      optional :cluster_name, :string, 2
      optional :config, :message, 3, "google.cloud.dataproc.v1.ClusterConfig"
      map :labels, :string, :string, 8
      optional :status, :message, 4, "google.cloud.dataproc.v1.ClusterStatus"
      repeated :status_history, :message, 7, "google.cloud.dataproc.v1.ClusterStatus"
      optional :cluster_uuid, :string, 6
      optional :metrics, :message, 9, "google.cloud.dataproc.v1.ClusterMetrics"
    end
    add_message "google.cloud.dataproc.v1.ClusterConfig" do
      optional :config_bucket, :string, 1
      optional :temp_bucket, :string, 2
      optional :gce_cluster_config, :message, 8, "google.cloud.dataproc.v1.GceClusterConfig"
      optional :master_config, :message, 9, "google.cloud.dataproc.v1.InstanceGroupConfig"
      optional :worker_config, :message, 10, "google.cloud.dataproc.v1.InstanceGroupConfig"
      optional :secondary_worker_config, :message, 12, "google.cloud.dataproc.v1.InstanceGroupConfig"
      optional :software_config, :message, 13, "google.cloud.dataproc.v1.SoftwareConfig"
      repeated :initialization_actions, :message, 11, "google.cloud.dataproc.v1.NodeInitializationAction"
      optional :encryption_config, :message, 15, "google.cloud.dataproc.v1.EncryptionConfig"
      optional :autoscaling_config, :message, 18, "google.cloud.dataproc.v1.AutoscalingConfig"
      optional :security_config, :message, 16, "google.cloud.dataproc.v1.SecurityConfig"
      optional :lifecycle_config, :message, 17, "google.cloud.dataproc.v1.LifecycleConfig"
      optional :endpoint_config, :message, 19, "google.cloud.dataproc.v1.EndpointConfig"
    end
    add_message "google.cloud.dataproc.v1.EndpointConfig" do
      map :http_ports, :string, :string, 1
      optional :enable_http_port_access, :bool, 2
    end
    add_message "google.cloud.dataproc.v1.AutoscalingConfig" do
      optional :policy_uri, :string, 1
    end
    add_message "google.cloud.dataproc.v1.EncryptionConfig" do
      optional :gce_pd_kms_key_name, :string, 1
    end
    add_message "google.cloud.dataproc.v1.GceClusterConfig" do
      optional :zone_uri, :string, 1
      optional :network_uri, :string, 2
      optional :subnetwork_uri, :string, 6
      optional :internal_ip_only, :bool, 7
      optional :service_account, :string, 8
      repeated :service_account_scopes, :string, 3
      repeated :tags, :string, 4
      map :metadata, :string, :string, 5
      optional :reservation_affinity, :message, 11, "google.cloud.dataproc.v1.ReservationAffinity"
    end
    add_message "google.cloud.dataproc.v1.InstanceGroupConfig" do
      optional :num_instances, :int32, 1
      repeated :instance_names, :string, 2
      optional :image_uri, :string, 3
      optional :machine_type_uri, :string, 4
      optional :disk_config, :message, 5, "google.cloud.dataproc.v1.DiskConfig"
      optional :is_preemptible, :bool, 6
      optional :preemptibility, :enum, 10, "google.cloud.dataproc.v1.InstanceGroupConfig.Preemptibility"
      optional :managed_group_config, :message, 7, "google.cloud.dataproc.v1.ManagedGroupConfig"
      repeated :accelerators, :message, 8, "google.cloud.dataproc.v1.AcceleratorConfig"
      optional :min_cpu_platform, :string, 9
    end
    add_enum "google.cloud.dataproc.v1.InstanceGroupConfig.Preemptibility" do
      value :PREEMPTIBILITY_UNSPECIFIED, 0
      value :NON_PREEMPTIBLE, 1
      value :PREEMPTIBLE, 2
    end
    add_message "google.cloud.dataproc.v1.ManagedGroupConfig" do
      optional :instance_template_name, :string, 1
      optional :instance_group_manager_name, :string, 2
    end
    add_message "google.cloud.dataproc.v1.AcceleratorConfig" do
      optional :accelerator_type_uri, :string, 1
      optional :accelerator_count, :int32, 2
    end
    add_message "google.cloud.dataproc.v1.DiskConfig" do
      optional :boot_disk_type, :string, 3
      optional :boot_disk_size_gb, :int32, 1
      optional :num_local_ssds, :int32, 2
    end
    add_message "google.cloud.dataproc.v1.NodeInitializationAction" do
      optional :executable_file, :string, 1
      optional :execution_timeout, :message, 2, "google.protobuf.Duration"
    end
    add_message "google.cloud.dataproc.v1.ClusterStatus" do
      optional :state, :enum, 1, "google.cloud.dataproc.v1.ClusterStatus.State"
      optional :detail, :string, 2
      optional :state_start_time, :message, 3, "google.protobuf.Timestamp"
      optional :substate, :enum, 4, "google.cloud.dataproc.v1.ClusterStatus.Substate"
    end
    add_enum "google.cloud.dataproc.v1.ClusterStatus.State" do
      value :UNKNOWN, 0
      value :CREATING, 1
      value :RUNNING, 2
      value :ERROR, 3
      value :DELETING, 4
      value :UPDATING, 5
    end
    add_enum "google.cloud.dataproc.v1.ClusterStatus.Substate" do
      value :UNSPECIFIED, 0
      value :UNHEALTHY, 1
      value :STALE_STATUS, 2
    end
    add_message "google.cloud.dataproc.v1.SecurityConfig" do
      optional :kerberos_config, :message, 1, "google.cloud.dataproc.v1.KerberosConfig"
    end
    add_message "google.cloud.dataproc.v1.KerberosConfig" do
      optional :enable_kerberos, :bool, 1
      optional :root_principal_password_uri, :string, 2
      optional :kms_key_uri, :string, 3
      optional :keystore_uri, :string, 4
      optional :truststore_uri, :string, 5
      optional :keystore_password_uri, :string, 6
      optional :key_password_uri, :string, 7
      optional :truststore_password_uri, :string, 8
      optional :cross_realm_trust_realm, :string, 9
      optional :cross_realm_trust_kdc, :string, 10
      optional :cross_realm_trust_admin_server, :string, 11
      optional :cross_realm_trust_shared_password_uri, :string, 12
      optional :kdc_db_key_uri, :string, 13
      optional :tgt_lifetime_hours, :int32, 14
      optional :realm, :string, 15
    end
    add_message "google.cloud.dataproc.v1.SoftwareConfig" do
      optional :image_version, :string, 1
      map :properties, :string, :string, 2
      repeated :optional_components, :enum, 3, "google.cloud.dataproc.v1.Component"
    end
    add_message "google.cloud.dataproc.v1.LifecycleConfig" do
      optional :idle_delete_ttl, :message, 1, "google.protobuf.Duration"
      optional :idle_start_time, :message, 4, "google.protobuf.Timestamp"
      oneof :ttl do
        optional :auto_delete_time, :message, 2, "google.protobuf.Timestamp"
        optional :auto_delete_ttl, :message, 3, "google.protobuf.Duration"
      end
    end
    add_message "google.cloud.dataproc.v1.ClusterMetrics" do
      map :hdfs_metrics, :string, :int64, 1
      map :yarn_metrics, :string, :int64, 2
    end
    add_message "google.cloud.dataproc.v1.CreateClusterRequest" do
      optional :project_id, :string, 1
      optional :region, :string, 3
      optional :cluster, :message, 2, "google.cloud.dataproc.v1.Cluster"
      optional :request_id, :string, 4
    end
    add_message "google.cloud.dataproc.v1.UpdateClusterRequest" do
      optional :project_id, :string, 1
      optional :region, :string, 5
      optional :cluster_name, :string, 2
      optional :cluster, :message, 3, "google.cloud.dataproc.v1.Cluster"
      optional :graceful_decommission_timeout, :message, 6, "google.protobuf.Duration"
      optional :update_mask, :message, 4, "google.protobuf.FieldMask"
      optional :request_id, :string, 7
    end
    add_message "google.cloud.dataproc.v1.DeleteClusterRequest" do
      optional :project_id, :string, 1
      optional :region, :string, 3
      optional :cluster_name, :string, 2
      optional :cluster_uuid, :string, 4
      optional :request_id, :string, 5
    end
    add_message "google.cloud.dataproc.v1.GetClusterRequest" do
      optional :project_id, :string, 1
      optional :region, :string, 3
      optional :cluster_name, :string, 2
    end
    add_message "google.cloud.dataproc.v1.ListClustersRequest" do
      optional :project_id, :string, 1
      optional :region, :string, 4
      optional :filter, :string, 5
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.dataproc.v1.ListClustersResponse" do
      repeated :clusters, :message, 1, "google.cloud.dataproc.v1.Cluster"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.dataproc.v1.DiagnoseClusterRequest" do
      optional :project_id, :string, 1
      optional :region, :string, 3
      optional :cluster_name, :string, 2
    end
    add_message "google.cloud.dataproc.v1.DiagnoseClusterResults" do
      optional :output_uri, :string, 1
    end
    add_message "google.cloud.dataproc.v1.ReservationAffinity" do
      optional :consume_reservation_type, :enum, 1, "google.cloud.dataproc.v1.ReservationAffinity.Type"
      optional :key, :string, 2
      repeated :values, :string, 3
    end
    add_enum "google.cloud.dataproc.v1.ReservationAffinity.Type" do
      value :TYPE_UNSPECIFIED, 0
      value :NO_RESERVATION, 1
      value :ANY_RESERVATION, 2
      value :SPECIFIC_RESERVATION, 3
    end
  end
end

module Google
  module Cloud
    module Dataproc
      module V1
        Cluster = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.Cluster").msgclass
        ClusterConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ClusterConfig").msgclass
        EndpointConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.EndpointConfig").msgclass
        AutoscalingConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.AutoscalingConfig").msgclass
        EncryptionConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.EncryptionConfig").msgclass
        GceClusterConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.GceClusterConfig").msgclass
        InstanceGroupConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.InstanceGroupConfig").msgclass
        InstanceGroupConfig::Preemptibility = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.InstanceGroupConfig.Preemptibility").enummodule
        ManagedGroupConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ManagedGroupConfig").msgclass
        AcceleratorConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.AcceleratorConfig").msgclass
        DiskConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.DiskConfig").msgclass
        NodeInitializationAction = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.NodeInitializationAction").msgclass
        ClusterStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ClusterStatus").msgclass
        ClusterStatus::State = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ClusterStatus.State").enummodule
        ClusterStatus::Substate = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ClusterStatus.Substate").enummodule
        SecurityConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.SecurityConfig").msgclass
        KerberosConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.KerberosConfig").msgclass
        SoftwareConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.SoftwareConfig").msgclass
        LifecycleConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.LifecycleConfig").msgclass
        ClusterMetrics = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ClusterMetrics").msgclass
        CreateClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.CreateClusterRequest").msgclass
        UpdateClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.UpdateClusterRequest").msgclass
        DeleteClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.DeleteClusterRequest").msgclass
        GetClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.GetClusterRequest").msgclass
        ListClustersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ListClustersRequest").msgclass
        ListClustersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ListClustersResponse").msgclass
        DiagnoseClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.DiagnoseClusterRequest").msgclass
        DiagnoseClusterResults = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.DiagnoseClusterResults").msgclass
        ReservationAffinity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ReservationAffinity").msgclass
        ReservationAffinity::Type = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dataproc.v1.ReservationAffinity.Type").enummodule
      end
    end
  end
end
