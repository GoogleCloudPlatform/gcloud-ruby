# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/devtools/cloudbuild/v1/cloudbuild.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/duration_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/devtools/cloudbuild/v1/cloudbuild.proto", :syntax => :proto3) do
    add_message "google.devtools.cloudbuild.v1.RetryBuildRequest" do
      optional :project_id, :string, 1
      optional :id, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.RunBuildTriggerRequest" do
      optional :project_id, :string, 1
      optional :trigger_id, :string, 2
      optional :source, :message, 3, "google.devtools.cloudbuild.v1.RepoSource"
    end
    add_message "google.devtools.cloudbuild.v1.StorageSource" do
      optional :bucket, :string, 1
      optional :object, :string, 2
      optional :generation, :int64, 3
    end
    add_message "google.devtools.cloudbuild.v1.RepoSource" do
      optional :project_id, :string, 1
      optional :repo_name, :string, 2
      optional :dir, :string, 7
      optional :invert_regex, :bool, 8
      map :substitutions, :string, :string, 9
      oneof :revision do
        optional :branch_name, :string, 3
        optional :tag_name, :string, 4
        optional :commit_sha, :string, 5
      end
    end
    add_message "google.devtools.cloudbuild.v1.Source" do
      oneof :source do
        optional :storage_source, :message, 2, "google.devtools.cloudbuild.v1.StorageSource"
        optional :repo_source, :message, 3, "google.devtools.cloudbuild.v1.RepoSource"
      end
    end
    add_message "google.devtools.cloudbuild.v1.BuiltImage" do
      optional :name, :string, 1
      optional :digest, :string, 3
      optional :push_timing, :message, 4, "google.devtools.cloudbuild.v1.TimeSpan"
    end
    add_message "google.devtools.cloudbuild.v1.BuildStep" do
      optional :name, :string, 1
      repeated :env, :string, 2
      repeated :args, :string, 3
      optional :dir, :string, 4
      optional :id, :string, 5
      repeated :wait_for, :string, 6
      optional :entrypoint, :string, 7
      repeated :secret_env, :string, 8
      repeated :volumes, :message, 9, "google.devtools.cloudbuild.v1.Volume"
      optional :timing, :message, 10, "google.devtools.cloudbuild.v1.TimeSpan"
      optional :pull_timing, :message, 13, "google.devtools.cloudbuild.v1.TimeSpan"
      optional :timeout, :message, 11, "google.protobuf.Duration"
      optional :status, :enum, 12, "google.devtools.cloudbuild.v1.Build.Status"
    end
    add_message "google.devtools.cloudbuild.v1.Volume" do
      optional :name, :string, 1
      optional :path, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.Results" do
      repeated :images, :message, 2, "google.devtools.cloudbuild.v1.BuiltImage"
      repeated :build_step_images, :string, 3
      optional :artifact_manifest, :string, 4
      optional :num_artifacts, :int64, 5
      repeated :build_step_outputs, :bytes, 6
      optional :artifact_timing, :message, 7, "google.devtools.cloudbuild.v1.TimeSpan"
    end
    add_message "google.devtools.cloudbuild.v1.ArtifactResult" do
      optional :location, :string, 1
      repeated :file_hash, :message, 2, "google.devtools.cloudbuild.v1.FileHashes"
    end
    add_message "google.devtools.cloudbuild.v1.Build" do
      optional :id, :string, 1
      optional :project_id, :string, 16
      optional :status, :enum, 2, "google.devtools.cloudbuild.v1.Build.Status"
      optional :status_detail, :string, 24
      optional :source, :message, 3, "google.devtools.cloudbuild.v1.Source"
      repeated :steps, :message, 11, "google.devtools.cloudbuild.v1.BuildStep"
      optional :results, :message, 10, "google.devtools.cloudbuild.v1.Results"
      optional :create_time, :message, 6, "google.protobuf.Timestamp"
      optional :start_time, :message, 7, "google.protobuf.Timestamp"
      optional :finish_time, :message, 8, "google.protobuf.Timestamp"
      optional :timeout, :message, 12, "google.protobuf.Duration"
      repeated :images, :string, 13
      optional :queue_ttl, :message, 40, "google.protobuf.Duration"
      optional :artifacts, :message, 37, "google.devtools.cloudbuild.v1.Artifacts"
      optional :logs_bucket, :string, 19
      optional :source_provenance, :message, 21, "google.devtools.cloudbuild.v1.SourceProvenance"
      optional :build_trigger_id, :string, 22
      optional :options, :message, 23, "google.devtools.cloudbuild.v1.BuildOptions"
      optional :log_url, :string, 25
      map :substitutions, :string, :string, 29
      repeated :tags, :string, 31
      repeated :secrets, :message, 32, "google.devtools.cloudbuild.v1.Secret"
      map :timing, :string, :message, 33, "google.devtools.cloudbuild.v1.TimeSpan"
    end
    add_enum "google.devtools.cloudbuild.v1.Build.Status" do
      value :STATUS_UNKNOWN, 0
      value :QUEUED, 1
      value :WORKING, 2
      value :SUCCESS, 3
      value :FAILURE, 4
      value :INTERNAL_ERROR, 5
      value :TIMEOUT, 6
      value :CANCELLED, 7
      value :EXPIRED, 9
    end
    add_message "google.devtools.cloudbuild.v1.Artifacts" do
      repeated :images, :string, 1
      optional :objects, :message, 2, "google.devtools.cloudbuild.v1.Artifacts.ArtifactObjects"
    end
    add_message "google.devtools.cloudbuild.v1.Artifacts.ArtifactObjects" do
      optional :location, :string, 1
      repeated :paths, :string, 2
      optional :timing, :message, 3, "google.devtools.cloudbuild.v1.TimeSpan"
    end
    add_message "google.devtools.cloudbuild.v1.TimeSpan" do
      optional :start_time, :message, 1, "google.protobuf.Timestamp"
      optional :end_time, :message, 2, "google.protobuf.Timestamp"
    end
    add_message "google.devtools.cloudbuild.v1.BuildOperationMetadata" do
      optional :build, :message, 1, "google.devtools.cloudbuild.v1.Build"
    end
    add_message "google.devtools.cloudbuild.v1.SourceProvenance" do
      optional :resolved_storage_source, :message, 3, "google.devtools.cloudbuild.v1.StorageSource"
      optional :resolved_repo_source, :message, 6, "google.devtools.cloudbuild.v1.RepoSource"
      map :file_hashes, :string, :message, 4, "google.devtools.cloudbuild.v1.FileHashes"
    end
    add_message "google.devtools.cloudbuild.v1.FileHashes" do
      repeated :file_hash, :message, 1, "google.devtools.cloudbuild.v1.Hash"
    end
    add_message "google.devtools.cloudbuild.v1.Hash" do
      optional :type, :enum, 1, "google.devtools.cloudbuild.v1.Hash.HashType"
      optional :value, :bytes, 2
    end
    add_enum "google.devtools.cloudbuild.v1.Hash.HashType" do
      value :NONE, 0
      value :SHA256, 1
      value :MD5, 2
    end
    add_message "google.devtools.cloudbuild.v1.Secret" do
      optional :kms_key_name, :string, 1
      map :secret_env, :string, :bytes, 3
    end
    add_message "google.devtools.cloudbuild.v1.CreateBuildRequest" do
      optional :project_id, :string, 1
      optional :build, :message, 2, "google.devtools.cloudbuild.v1.Build"
    end
    add_message "google.devtools.cloudbuild.v1.GetBuildRequest" do
      optional :project_id, :string, 1
      optional :id, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.ListBuildsRequest" do
      optional :project_id, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :filter, :string, 8
    end
    add_message "google.devtools.cloudbuild.v1.ListBuildsResponse" do
      repeated :builds, :message, 1, "google.devtools.cloudbuild.v1.Build"
      optional :next_page_token, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.CancelBuildRequest" do
      optional :project_id, :string, 1
      optional :id, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.BuildTrigger" do
      optional :id, :string, 1
      optional :description, :string, 10
      optional :name, :string, 21
      repeated :tags, :string, 19
      optional :trigger_template, :message, 7, "google.devtools.cloudbuild.v1.RepoSource"
      optional :github, :message, 13, "google.devtools.cloudbuild.v1.GitHubEventsConfig"
      optional :create_time, :message, 5, "google.protobuf.Timestamp"
      optional :disabled, :bool, 9
      map :substitutions, :string, :string, 11
      repeated :ignored_files, :string, 15
      repeated :included_files, :string, 16
      oneof :build_template do
        optional :build, :message, 4, "google.devtools.cloudbuild.v1.Build"
        optional :filename, :string, 8
      end
    end
    add_message "google.devtools.cloudbuild.v1.GitHubEventsConfig" do
      optional :installation_id, :int64, 1
      optional :owner, :string, 6
      optional :name, :string, 7
      oneof :event do
        optional :pull_request, :message, 4, "google.devtools.cloudbuild.v1.PullRequestFilter"
        optional :push, :message, 5, "google.devtools.cloudbuild.v1.PushFilter"
      end
    end
    add_message "google.devtools.cloudbuild.v1.PullRequestFilter" do
      optional :comment_control, :enum, 5, "google.devtools.cloudbuild.v1.PullRequestFilter.CommentControl"
      optional :invert_regex, :bool, 6
      oneof :git_ref do
        optional :branch, :string, 2
      end
    end
    add_enum "google.devtools.cloudbuild.v1.PullRequestFilter.CommentControl" do
      value :COMMENTS_DISABLED, 0
      value :COMMENTS_ENABLED, 1
    end
    add_message "google.devtools.cloudbuild.v1.PushFilter" do
      optional :invert_regex, :bool, 4
      oneof :git_ref do
        optional :branch, :string, 2
        optional :tag, :string, 3
      end
    end
    add_message "google.devtools.cloudbuild.v1.CreateBuildTriggerRequest" do
      optional :project_id, :string, 1
      optional :trigger, :message, 2, "google.devtools.cloudbuild.v1.BuildTrigger"
    end
    add_message "google.devtools.cloudbuild.v1.GetBuildTriggerRequest" do
      optional :project_id, :string, 1
      optional :trigger_id, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.ListBuildTriggersRequest" do
      optional :project_id, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.devtools.cloudbuild.v1.ListBuildTriggersResponse" do
      repeated :triggers, :message, 1, "google.devtools.cloudbuild.v1.BuildTrigger"
      optional :next_page_token, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.DeleteBuildTriggerRequest" do
      optional :project_id, :string, 1
      optional :trigger_id, :string, 2
    end
    add_message "google.devtools.cloudbuild.v1.UpdateBuildTriggerRequest" do
      optional :project_id, :string, 1
      optional :trigger_id, :string, 2
      optional :trigger, :message, 3, "google.devtools.cloudbuild.v1.BuildTrigger"
    end
    add_message "google.devtools.cloudbuild.v1.BuildOptions" do
      repeated :source_provenance_hash, :enum, 1, "google.devtools.cloudbuild.v1.Hash.HashType"
      optional :requested_verify_option, :enum, 2, "google.devtools.cloudbuild.v1.BuildOptions.VerifyOption"
      optional :machine_type, :enum, 3, "google.devtools.cloudbuild.v1.BuildOptions.MachineType"
      optional :disk_size_gb, :int64, 6
      optional :substitution_option, :enum, 4, "google.devtools.cloudbuild.v1.BuildOptions.SubstitutionOption"
      optional :log_streaming_option, :enum, 5, "google.devtools.cloudbuild.v1.BuildOptions.LogStreamingOption"
      optional :worker_pool, :string, 7
      optional :logging, :enum, 11, "google.devtools.cloudbuild.v1.BuildOptions.LoggingMode"
      repeated :env, :string, 12
      repeated :secret_env, :string, 13
      repeated :volumes, :message, 14, "google.devtools.cloudbuild.v1.Volume"
    end
    add_enum "google.devtools.cloudbuild.v1.BuildOptions.VerifyOption" do
      value :NOT_VERIFIED, 0
      value :VERIFIED, 1
    end
    add_enum "google.devtools.cloudbuild.v1.BuildOptions.MachineType" do
      value :UNSPECIFIED, 0
      value :N1_HIGHCPU_8, 1
      value :N1_HIGHCPU_32, 2
    end
    add_enum "google.devtools.cloudbuild.v1.BuildOptions.SubstitutionOption" do
      value :MUST_MATCH, 0
      value :ALLOW_LOOSE, 1
    end
    add_enum "google.devtools.cloudbuild.v1.BuildOptions.LogStreamingOption" do
      value :STREAM_DEFAULT, 0
      value :STREAM_ON, 1
      value :STREAM_OFF, 2
    end
    add_enum "google.devtools.cloudbuild.v1.BuildOptions.LoggingMode" do
      value :LOGGING_UNSPECIFIED, 0
      value :LEGACY, 1
      value :GCS_ONLY, 2
    end
    add_message "google.devtools.cloudbuild.v1.WorkerPool" do
      optional :name, :string, 14
      optional :project_id, :string, 2
      optional :service_account_email, :string, 3
      optional :worker_count, :int64, 4
      optional :worker_config, :message, 16, "google.devtools.cloudbuild.v1.WorkerConfig"
      repeated :regions, :enum, 9, "google.devtools.cloudbuild.v1.WorkerPool.Region"
      optional :create_time, :message, 11, "google.protobuf.Timestamp"
      optional :update_time, :message, 17, "google.protobuf.Timestamp"
      optional :delete_time, :message, 12, "google.protobuf.Timestamp"
      optional :status, :enum, 13, "google.devtools.cloudbuild.v1.WorkerPool.Status"
    end
    add_enum "google.devtools.cloudbuild.v1.WorkerPool.Region" do
      value :REGION_UNSPECIFIED, 0
      value :US_CENTRAL1, 1
      value :US_WEST1, 2
      value :US_EAST1, 3
      value :US_EAST4, 4
    end
    add_enum "google.devtools.cloudbuild.v1.WorkerPool.Status" do
      value :STATUS_UNSPECIFIED, 0
      value :CREATING, 1
      value :RUNNING, 2
      value :DELETING, 3
      value :DELETED, 4
    end
    add_message "google.devtools.cloudbuild.v1.WorkerConfig" do
      optional :machine_type, :string, 1
      optional :disk_size_gb, :int64, 2
      optional :network, :message, 3, "google.devtools.cloudbuild.v1.Network"
      optional :tag, :string, 4
    end
    add_message "google.devtools.cloudbuild.v1.Network" do
      optional :project_id, :string, 1
      optional :network, :string, 2
      optional :subnetwork, :string, 3
    end
    add_message "google.devtools.cloudbuild.v1.CreateWorkerPoolRequest" do
      optional :parent, :string, 1
      optional :worker_pool, :message, 2, "google.devtools.cloudbuild.v1.WorkerPool"
    end
    add_message "google.devtools.cloudbuild.v1.GetWorkerPoolRequest" do
      optional :name, :string, 1
    end
    add_message "google.devtools.cloudbuild.v1.DeleteWorkerPoolRequest" do
      optional :name, :string, 1
    end
    add_message "google.devtools.cloudbuild.v1.UpdateWorkerPoolRequest" do
      optional :name, :string, 2
      optional :worker_pool, :message, 3, "google.devtools.cloudbuild.v1.WorkerPool"
    end
    add_message "google.devtools.cloudbuild.v1.ListWorkerPoolsRequest" do
      optional :parent, :string, 1
    end
    add_message "google.devtools.cloudbuild.v1.ListWorkerPoolsResponse" do
      repeated :worker_pools, :message, 1, "google.devtools.cloudbuild.v1.WorkerPool"
    end
  end
end

module Google
  module Cloud
    module Build
      module V1
        RetryBuildRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.RetryBuildRequest").msgclass
        RunBuildTriggerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.RunBuildTriggerRequest").msgclass
        StorageSource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.StorageSource").msgclass
        RepoSource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.RepoSource").msgclass
        Source = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Source").msgclass
        BuiltImage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuiltImage").msgclass
        BuildStep = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildStep").msgclass
        Volume = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Volume").msgclass
        Results = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Results").msgclass
        ArtifactResult = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ArtifactResult").msgclass
        Build = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Build").msgclass
        Build::Status = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Build.Status").enummodule
        Artifacts = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Artifacts").msgclass
        Artifacts::ArtifactObjects = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Artifacts.ArtifactObjects").msgclass
        TimeSpan = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.TimeSpan").msgclass
        BuildOperationMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOperationMetadata").msgclass
        SourceProvenance = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.SourceProvenance").msgclass
        FileHashes = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.FileHashes").msgclass
        Hash = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Hash").msgclass
        Hash::HashType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Hash.HashType").enummodule
        Secret = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Secret").msgclass
        CreateBuildRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.CreateBuildRequest").msgclass
        GetBuildRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.GetBuildRequest").msgclass
        ListBuildsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ListBuildsRequest").msgclass
        ListBuildsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ListBuildsResponse").msgclass
        CancelBuildRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.CancelBuildRequest").msgclass
        BuildTrigger = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildTrigger").msgclass
        GitHubEventsConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.GitHubEventsConfig").msgclass
        PullRequestFilter = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.PullRequestFilter").msgclass
        PullRequestFilter::CommentControl = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.PullRequestFilter.CommentControl").enummodule
        PushFilter = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.PushFilter").msgclass
        CreateBuildTriggerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.CreateBuildTriggerRequest").msgclass
        GetBuildTriggerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.GetBuildTriggerRequest").msgclass
        ListBuildTriggersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ListBuildTriggersRequest").msgclass
        ListBuildTriggersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ListBuildTriggersResponse").msgclass
        DeleteBuildTriggerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.DeleteBuildTriggerRequest").msgclass
        UpdateBuildTriggerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.UpdateBuildTriggerRequest").msgclass
        BuildOptions = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOptions").msgclass
        BuildOptions::VerifyOption = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOptions.VerifyOption").enummodule
        BuildOptions::MachineType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOptions.MachineType").enummodule
        BuildOptions::SubstitutionOption = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOptions.SubstitutionOption").enummodule
        BuildOptions::LogStreamingOption = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOptions.LogStreamingOption").enummodule
        BuildOptions::LoggingMode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.BuildOptions.LoggingMode").enummodule
        WorkerPool = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.WorkerPool").msgclass
        WorkerPool::Region = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.WorkerPool.Region").enummodule
        WorkerPool::Status = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.WorkerPool.Status").enummodule
        WorkerConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.WorkerConfig").msgclass
        Network = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.Network").msgclass
        CreateWorkerPoolRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.CreateWorkerPoolRequest").msgclass
        GetWorkerPoolRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.GetWorkerPoolRequest").msgclass
        DeleteWorkerPoolRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.DeleteWorkerPoolRequest").msgclass
        UpdateWorkerPoolRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.UpdateWorkerPoolRequest").msgclass
        ListWorkerPoolsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ListWorkerPoolsRequest").msgclass
        ListWorkerPoolsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.cloudbuild.v1.ListWorkerPoolsResponse").msgclass
      end
    end
  end
end
