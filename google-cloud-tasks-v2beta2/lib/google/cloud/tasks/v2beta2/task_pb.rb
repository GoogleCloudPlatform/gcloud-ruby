# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/tasks/v2beta2/task.proto

require 'google/protobuf'

require 'google/api/resource_pb'
require 'google/cloud/tasks/v2beta2/target_pb'
require 'google/protobuf/timestamp_pb'
require 'google/rpc/status_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/tasks/v2beta2/task.proto", :syntax => :proto3) do
    add_message "google.cloud.tasks.v2beta2.Task" do
      optional :name, :string, 1
      optional :schedule_time, :message, 5, "google.protobuf.Timestamp"
      optional :create_time, :message, 6, "google.protobuf.Timestamp"
      optional :status, :message, 7, "google.cloud.tasks.v2beta2.TaskStatus"
      optional :view, :enum, 8, "google.cloud.tasks.v2beta2.Task.View"
      oneof :payload_type do
        optional :app_engine_http_request, :message, 3, "google.cloud.tasks.v2beta2.AppEngineHttpRequest"
        optional :pull_message, :message, 4, "google.cloud.tasks.v2beta2.PullMessage"
      end
    end
    add_enum "google.cloud.tasks.v2beta2.Task.View" do
      value :VIEW_UNSPECIFIED, 0
      value :BASIC, 1
      value :FULL, 2
    end
    add_message "google.cloud.tasks.v2beta2.TaskStatus" do
      optional :attempt_dispatch_count, :int32, 1
      optional :attempt_response_count, :int32, 2
      optional :first_attempt_status, :message, 3, "google.cloud.tasks.v2beta2.AttemptStatus"
      optional :last_attempt_status, :message, 4, "google.cloud.tasks.v2beta2.AttemptStatus"
    end
    add_message "google.cloud.tasks.v2beta2.AttemptStatus" do
      optional :schedule_time, :message, 1, "google.protobuf.Timestamp"
      optional :dispatch_time, :message, 2, "google.protobuf.Timestamp"
      optional :response_time, :message, 3, "google.protobuf.Timestamp"
      optional :response_status, :message, 4, "google.rpc.Status"
    end
  end
end

module Google
  module Cloud
    module Tasks
      module V2beta2
        Task = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.Task").msgclass
        Task::View = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.Task.View").enummodule
        TaskStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.TaskStatus").msgclass
        AttemptStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.AttemptStatus").msgclass
      end
    end
  end
end
