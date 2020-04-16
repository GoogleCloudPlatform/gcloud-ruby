# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/tasks/v2beta2/cloudtasks.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/tasks/v2beta2/queue_pb'
require 'google/cloud/tasks/v2beta2/task_pb'
require 'google/iam/v1/iam_policy_pb'
require 'google/iam/v1/policy_pb'
require 'google/protobuf/duration_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/tasks/v2beta2/cloudtasks.proto", :syntax => :proto3) do
    add_message "google.cloud.tasks.v2beta2.ListQueuesRequest" do
      optional :parent, :string, 1
      optional :filter, :string, 2
      optional :page_size, :int32, 3
      optional :page_token, :string, 4
    end
    add_message "google.cloud.tasks.v2beta2.ListQueuesResponse" do
      repeated :queues, :message, 1, "google.cloud.tasks.v2beta2.Queue"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.tasks.v2beta2.GetQueueRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.tasks.v2beta2.CreateQueueRequest" do
      optional :parent, :string, 1
      optional :queue, :message, 2, "google.cloud.tasks.v2beta2.Queue"
    end
    add_message "google.cloud.tasks.v2beta2.UpdateQueueRequest" do
      optional :queue, :message, 1, "google.cloud.tasks.v2beta2.Queue"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.tasks.v2beta2.DeleteQueueRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.tasks.v2beta2.PurgeQueueRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.tasks.v2beta2.PauseQueueRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.tasks.v2beta2.ResumeQueueRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.tasks.v2beta2.ListTasksRequest" do
      optional :parent, :string, 1
      optional :response_view, :enum, 2, "google.cloud.tasks.v2beta2.Task.View"
      optional :page_size, :int32, 4
      optional :page_token, :string, 5
    end
    add_message "google.cloud.tasks.v2beta2.ListTasksResponse" do
      repeated :tasks, :message, 1, "google.cloud.tasks.v2beta2.Task"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.tasks.v2beta2.GetTaskRequest" do
      optional :name, :string, 1
      optional :response_view, :enum, 2, "google.cloud.tasks.v2beta2.Task.View"
    end
    add_message "google.cloud.tasks.v2beta2.CreateTaskRequest" do
      optional :parent, :string, 1
      optional :task, :message, 2, "google.cloud.tasks.v2beta2.Task"
      optional :response_view, :enum, 3, "google.cloud.tasks.v2beta2.Task.View"
    end
    add_message "google.cloud.tasks.v2beta2.DeleteTaskRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.tasks.v2beta2.LeaseTasksRequest" do
      optional :parent, :string, 1
      optional :max_tasks, :int32, 2
      optional :lease_duration, :message, 3, "google.protobuf.Duration"
      optional :response_view, :enum, 4, "google.cloud.tasks.v2beta2.Task.View"
      optional :filter, :string, 5
    end
    add_message "google.cloud.tasks.v2beta2.LeaseTasksResponse" do
      repeated :tasks, :message, 1, "google.cloud.tasks.v2beta2.Task"
    end
    add_message "google.cloud.tasks.v2beta2.AcknowledgeTaskRequest" do
      optional :name, :string, 1
      optional :schedule_time, :message, 2, "google.protobuf.Timestamp"
    end
    add_message "google.cloud.tasks.v2beta2.RenewLeaseRequest" do
      optional :name, :string, 1
      optional :schedule_time, :message, 2, "google.protobuf.Timestamp"
      optional :lease_duration, :message, 3, "google.protobuf.Duration"
      optional :response_view, :enum, 4, "google.cloud.tasks.v2beta2.Task.View"
    end
    add_message "google.cloud.tasks.v2beta2.CancelLeaseRequest" do
      optional :name, :string, 1
      optional :schedule_time, :message, 2, "google.protobuf.Timestamp"
      optional :response_view, :enum, 3, "google.cloud.tasks.v2beta2.Task.View"
    end
    add_message "google.cloud.tasks.v2beta2.RunTaskRequest" do
      optional :name, :string, 1
      optional :response_view, :enum, 2, "google.cloud.tasks.v2beta2.Task.View"
    end
  end
end

module Google
  module Cloud
    module Tasks
      module V2beta2
        ListQueuesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.ListQueuesRequest").msgclass
        ListQueuesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.ListQueuesResponse").msgclass
        GetQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.GetQueueRequest").msgclass
        CreateQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.CreateQueueRequest").msgclass
        UpdateQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.UpdateQueueRequest").msgclass
        DeleteQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.DeleteQueueRequest").msgclass
        PurgeQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.PurgeQueueRequest").msgclass
        PauseQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.PauseQueueRequest").msgclass
        ResumeQueueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.ResumeQueueRequest").msgclass
        ListTasksRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.ListTasksRequest").msgclass
        ListTasksResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.ListTasksResponse").msgclass
        GetTaskRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.GetTaskRequest").msgclass
        CreateTaskRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.CreateTaskRequest").msgclass
        DeleteTaskRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.DeleteTaskRequest").msgclass
        LeaseTasksRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.LeaseTasksRequest").msgclass
        LeaseTasksResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.LeaseTasksResponse").msgclass
        AcknowledgeTaskRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.AcknowledgeTaskRequest").msgclass
        RenewLeaseRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.RenewLeaseRequest").msgclass
        CancelLeaseRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.CancelLeaseRequest").msgclass
        RunTaskRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.tasks.v2beta2.RunTaskRequest").msgclass
      end
    end
  end
end
