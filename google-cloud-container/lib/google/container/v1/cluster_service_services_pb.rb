# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/container/v1/cluster_service.proto for package 'google.container.v1'
# Original file comments:
# Copyright 2018 Google LLC
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
require 'google/container/v1/cluster_service_pb'

module Google
  module Container
    module V1
      module ClusterManager
        # Google Kubernetes Engine Cluster Manager v1
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'google.container.v1.ClusterManager'

          # Lists all clusters owned by a project in either the specified zone or all
          # zones.
          rpc :ListClusters, ListClustersRequest, ListClustersResponse
          # Gets the details of a specific cluster.
          rpc :GetCluster, GetClusterRequest, Cluster
          # Creates a cluster, consisting of the specified number and type of Google
          # Compute Engine instances.
          #
          # By default, the cluster is created in the project's
          # [default network](/compute/docs/networks-and-firewalls#networks).
          #
          # One firewall is added for the cluster. After cluster creation,
          # the cluster creates routes for each node to allow the containers
          # on that node to communicate with all other instances in the
          # cluster.
          #
          # Finally, an entry is added to the project's global metadata indicating
          # which CIDR range is being used by the cluster.
          rpc :CreateCluster, CreateClusterRequest, Operation
          # Updates the settings of a specific cluster.
          rpc :UpdateCluster, UpdateClusterRequest, Operation
          # Updates the version and/or image type for a specific node pool.
          rpc :UpdateNodePool, UpdateNodePoolRequest, Operation
          # Sets the autoscaling settings for a specific node pool.
          rpc :SetNodePoolAutoscaling, SetNodePoolAutoscalingRequest, Operation
          # Sets the logging service for a specific cluster.
          rpc :SetLoggingService, SetLoggingServiceRequest, Operation
          # Sets the monitoring service for a specific cluster.
          rpc :SetMonitoringService, SetMonitoringServiceRequest, Operation
          # Sets the addons for a specific cluster.
          rpc :SetAddonsConfig, SetAddonsConfigRequest, Operation
          # Sets the locations for a specific cluster.
          rpc :SetLocations, SetLocationsRequest, Operation
          # Updates the master for a specific cluster.
          rpc :UpdateMaster, UpdateMasterRequest, Operation
          # Used to set master auth materials. Currently supports :-
          # Changing the admin password for a specific cluster.
          # This can be either via password generation or explicitly set the password.
          rpc :SetMasterAuth, SetMasterAuthRequest, Operation
          # Deletes the cluster, including the Kubernetes endpoint and all worker
          # nodes.
          #
          # Firewalls and routes that were configured during cluster creation
          # are also deleted.
          #
          # Other Google Compute Engine resources that might be in use by the cluster
          # (e.g. load balancer resources) will not be deleted if they weren't present
          # at the initial create time.
          rpc :DeleteCluster, DeleteClusterRequest, Operation
          # Lists all operations in a project in a specific zone or all zones.
          rpc :ListOperations, ListOperationsRequest, ListOperationsResponse
          # Gets the specified operation.
          rpc :GetOperation, GetOperationRequest, Operation
          # Cancels the specified operation.
          rpc :CancelOperation, CancelOperationRequest, Google::Protobuf::Empty
          # Returns configuration info about the Kubernetes Engine service.
          rpc :GetServerConfig, GetServerConfigRequest, ServerConfig
          # Lists the node pools for a cluster.
          rpc :ListNodePools, ListNodePoolsRequest, ListNodePoolsResponse
          # Retrieves the node pool requested.
          rpc :GetNodePool, GetNodePoolRequest, NodePool
          # Creates a node pool for a cluster.
          rpc :CreateNodePool, CreateNodePoolRequest, Operation
          # Deletes a node pool from a cluster.
          rpc :DeleteNodePool, DeleteNodePoolRequest, Operation
          # Roll back the previously Aborted or Failed NodePool upgrade.
          # This will be an no-op if the last upgrade successfully completed.
          rpc :RollbackNodePoolUpgrade, RollbackNodePoolUpgradeRequest, Operation
          # Sets the NodeManagement options for a node pool.
          rpc :SetNodePoolManagement, SetNodePoolManagementRequest, Operation
          # Sets labels on a cluster.
          rpc :SetLabels, SetLabelsRequest, Operation
          # Enables or disables the ABAC authorization mechanism on a cluster.
          rpc :SetLegacyAbac, SetLegacyAbacRequest, Operation
          # Start master IP rotation.
          rpc :StartIPRotation, StartIPRotationRequest, Operation
          # Completes master IP rotation.
          rpc :CompleteIPRotation, CompleteIPRotationRequest, Operation
          # Sets the size for a specific node pool.
          rpc :SetNodePoolSize, SetNodePoolSizeRequest, Operation
          # Enables/Disables Network Policy for a cluster.
          rpc :SetNetworkPolicy, SetNetworkPolicyRequest, Operation
          # Sets the maintenance policy for a cluster.
          rpc :SetMaintenancePolicy, SetMaintenancePolicyRequest, Operation
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
