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


module Google
  module Cloud
    module Tasks
      module V2beta3
        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::ListQueues ListQueues}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The location name.
        #     For example: `projects/PROJECT_ID/locations/LOCATION_ID`
        # @!attribute [rw] filter
        #   @return [String]
        #     `filter` can be used to specify a subset of queues. Any {Google::Cloud::Tasks::V2beta3::Queue Queue}
        #     field can be used as a filter and several operators as supported.
        #     For example: `<=, <, >=, >, !=, =, :`. The filter syntax is the same as
        #     described in
        #     [Stackdriver's Advanced Logs
        #     Filters](https://cloud.google.com/logging/docs/view/advanced_filters).
        #
        #     Sample filter "state: PAUSED".
        #
        #     Note that using filters might cause fewer queues than the
        #     requested page_size to be returned.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     Requested page size.
        #
        #     The maximum page size is 9800. If unspecified, the page size will
        #     be the maximum. Fewer queues than requested might be returned,
        #     even if more queues exist; use the
        #     {Google::Cloud::Tasks::V2beta3::ListQueuesResponse#next_page_token next_page_token} in the
        #     response to determine if more queues exist.
        # @!attribute [rw] page_token
        #   @return [String]
        #     A token identifying the page of results to return.
        #
        #     To request the first page results, page_token must be empty. To
        #     request the next page of results, page_token must be the value of
        #     {Google::Cloud::Tasks::V2beta3::ListQueuesResponse#next_page_token next_page_token} returned
        #     from the previous call to {Google::Cloud::Tasks::V2beta3::CloudTasks::ListQueues ListQueues}
        #     method. It is an error to switch the value of the
        #     {Google::Cloud::Tasks::V2beta3::ListQueuesRequest#filter filter} while iterating through pages.
        class ListQueuesRequest; end

        # Response message for {Google::Cloud::Tasks::V2beta3::CloudTasks::ListQueues ListQueues}.
        # @!attribute [rw] queues
        #   @return [Array<Google::Cloud::Tasks::V2beta3::Queue>]
        #     The list of queues.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     A token to retrieve next page of results.
        #
        #     To return the next page of results, call
        #     {Google::Cloud::Tasks::V2beta3::CloudTasks::ListQueues ListQueues} with this value as the
        #     {Google::Cloud::Tasks::V2beta3::ListQueuesRequest#page_token page_token}.
        #
        #     If the next_page_token is empty, there are no more results.
        #
        #     The page token is valid for only 2 hours.
        class ListQueuesResponse; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::GetQueue GetQueue}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the queue. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID`
        class GetQueueRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::CreateQueue CreateQueue}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The location name in which the queue will be created.
        #     For example: `projects/PROJECT_ID/locations/LOCATION_ID`
        #
        #     The list of allowed locations can be obtained by calling Cloud
        #     Tasks' implementation of
        #     {Google::Cloud::Location::Locations::ListLocations ListLocations}.
        # @!attribute [rw] queue
        #   @return [Google::Cloud::Tasks::V2beta3::Queue]
        #     Required. The queue to create.
        #
        #     {Google::Cloud::Tasks::V2beta3::Queue#name Queue's name} cannot be the same as an existing queue.
        class CreateQueueRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::UpdateQueue UpdateQueue}.
        # @!attribute [rw] queue
        #   @return [Google::Cloud::Tasks::V2beta3::Queue]
        #     Required. The queue to create or update.
        #
        #     The queue's {Google::Cloud::Tasks::V2beta3::Queue#name name} must be specified.
        #
        #     Output only fields cannot be modified using UpdateQueue.
        #     Any value specified for an output only field will be ignored.
        #     The queue's {Google::Cloud::Tasks::V2beta3::Queue#name name} cannot be changed.
        # @!attribute [rw] update_mask
        #   @return [Google::Protobuf::FieldMask]
        #     A mask used to specify which fields of the queue are being updated.
        #
        #     If empty, then all fields will be updated.
        class UpdateQueueRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::DeleteQueue DeleteQueue}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The queue name. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID`
        class DeleteQueueRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::PurgeQueue PurgeQueue}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The queue name. For example:
        #     `projects/PROJECT_ID/location/LOCATION_ID/queues/QUEUE_ID`
        class PurgeQueueRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::PauseQueue PauseQueue}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The queue name. For example:
        #     `projects/PROJECT_ID/location/LOCATION_ID/queues/QUEUE_ID`
        class PauseQueueRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::ResumeQueue ResumeQueue}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The queue name. For example:
        #     `projects/PROJECT_ID/location/LOCATION_ID/queues/QUEUE_ID`
        class ResumeQueueRequest; end

        # Request message for listing tasks using {Google::Cloud::Tasks::V2beta3::CloudTasks::ListTasks ListTasks}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The queue name. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID`
        # @!attribute [rw] response_view
        #   @return [Google::Cloud::Tasks::V2beta3::Task::View]
        #     The response_view specifies which subset of the {Google::Cloud::Tasks::V2beta3::Task Task} will be
        #     returned.
        #
        #     By default response_view is {Google::Cloud::Tasks::V2beta3::Task::View::BASIC BASIC}; not all
        #     information is retrieved by default because some data, such as
        #     payloads, might be desirable to return only when needed because
        #     of its large size or because of the sensitivity of data that it
        #     contains.
        #
        #     Authorization for {Google::Cloud::Tasks::V2beta3::Task::View::FULL FULL} requires
        #     `cloudtasks.tasks.fullView` [Google IAM](https://cloud.google.com/iam/)
        #     permission on the {Google::Cloud::Tasks::V2beta3::Task Task} resource.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     Maximum page size.
        #
        #     Fewer tasks than requested might be returned, even if more tasks exist; use
        #     {Google::Cloud::Tasks::V2beta3::ListTasksResponse#next_page_token next_page_token} in the response to
        #     determine if more tasks exist.
        #
        #     The maximum page size is 1000. If unspecified, the page size will be the
        #     maximum.
        # @!attribute [rw] page_token
        #   @return [String]
        #     A token identifying the page of results to return.
        #
        #     To request the first page results, page_token must be empty. To
        #     request the next page of results, page_token must be the value of
        #     {Google::Cloud::Tasks::V2beta3::ListTasksResponse#next_page_token next_page_token} returned
        #     from the previous call to {Google::Cloud::Tasks::V2beta3::CloudTasks::ListTasks ListTasks}
        #     method.
        #
        #     The page token is valid for only 2 hours.
        class ListTasksRequest; end

        # Response message for listing tasks using {Google::Cloud::Tasks::V2beta3::CloudTasks::ListTasks ListTasks}.
        # @!attribute [rw] tasks
        #   @return [Array<Google::Cloud::Tasks::V2beta3::Task>]
        #     The list of tasks.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     A token to retrieve next page of results.
        #
        #     To return the next page of results, call
        #     {Google::Cloud::Tasks::V2beta3::CloudTasks::ListTasks ListTasks} with this value as the
        #     {Google::Cloud::Tasks::V2beta3::ListTasksRequest#page_token page_token}.
        #
        #     If the next_page_token is empty, there are no more results.
        class ListTasksResponse; end

        # Request message for getting a task using {Google::Cloud::Tasks::V2beta3::CloudTasks::GetTask GetTask}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The task name. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID/tasks/TASK_ID`
        # @!attribute [rw] response_view
        #   @return [Google::Cloud::Tasks::V2beta3::Task::View]
        #     The response_view specifies which subset of the {Google::Cloud::Tasks::V2beta3::Task Task} will be
        #     returned.
        #
        #     By default response_view is {Google::Cloud::Tasks::V2beta3::Task::View::BASIC BASIC}; not all
        #     information is retrieved by default because some data, such as
        #     payloads, might be desirable to return only when needed because
        #     of its large size or because of the sensitivity of data that it
        #     contains.
        #
        #     Authorization for {Google::Cloud::Tasks::V2beta3::Task::View::FULL FULL} requires
        #     `cloudtasks.tasks.fullView` [Google IAM](https://cloud.google.com/iam/)
        #     permission on the {Google::Cloud::Tasks::V2beta3::Task Task} resource.
        class GetTaskRequest; end

        # Request message for {Google::Cloud::Tasks::V2beta3::CloudTasks::CreateTask CreateTask}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The queue name. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID`
        #
        #     The queue must already exist.
        # @!attribute [rw] task
        #   @return [Google::Cloud::Tasks::V2beta3::Task]
        #     Required. The task to add.
        #
        #     Task names have the following format:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID/tasks/TASK_ID`.
        #     The user can optionally specify a task {Google::Cloud::Tasks::V2beta3::Task#name name}. If a
        #     name is not specified then the system will generate a random
        #     unique task id, which will be set in the task returned in the
        #     {Google::Cloud::Tasks::V2beta3::Task#name response}.
        #
        #     If {Google::Cloud::Tasks::V2beta3::Task#schedule_time schedule_time} is not set or is in the
        #     past then Cloud Tasks will set it to the current time.
        #
        #     Task De-duplication:
        #
        #     Explicitly specifying a task ID enables task de-duplication.  If
        #     a task's ID is identical to that of an existing task or a task
        #     that was deleted or executed recently then the call will fail
        #     with {Google::Rpc::Code::ALREADY_EXISTS ALREADY_EXISTS}.
        #     If the task's queue was created using Cloud Tasks, then another task with
        #     the same name can't be created for ~1hour after the original task was
        #     deleted or executed. If the task's queue was created using queue.yaml or
        #     queue.xml, then another task with the same name can't be created
        #     for ~9days after the original task was deleted or executed.
        #
        #     Because there is an extra lookup cost to identify duplicate task
        #     names, these {Google::Cloud::Tasks::V2beta3::CloudTasks::CreateTask CreateTask} calls have significantly
        #     increased latency. Using hashed strings for the task id or for
        #     the prefix of the task id is recommended. Choosing task ids that
        #     are sequential or have sequential prefixes, for example using a
        #     timestamp, causes an increase in latency and error rates in all
        #     task commands. The infrastructure relies on an approximately
        #     uniform distribution of task ids to store and serve tasks
        #     efficiently.
        # @!attribute [rw] response_view
        #   @return [Google::Cloud::Tasks::V2beta3::Task::View]
        #     The response_view specifies which subset of the {Google::Cloud::Tasks::V2beta3::Task Task} will be
        #     returned.
        #
        #     By default response_view is {Google::Cloud::Tasks::V2beta3::Task::View::BASIC BASIC}; not all
        #     information is retrieved by default because some data, such as
        #     payloads, might be desirable to return only when needed because
        #     of its large size or because of the sensitivity of data that it
        #     contains.
        #
        #     Authorization for {Google::Cloud::Tasks::V2beta3::Task::View::FULL FULL} requires
        #     `cloudtasks.tasks.fullView` [Google IAM](https://cloud.google.com/iam/)
        #     permission on the {Google::Cloud::Tasks::V2beta3::Task Task} resource.
        class CreateTaskRequest; end

        # Request message for deleting a task using
        # {Google::Cloud::Tasks::V2beta3::CloudTasks::DeleteTask DeleteTask}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The task name. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID/tasks/TASK_ID`
        class DeleteTaskRequest; end

        # Request message for forcing a task to run now using
        # {Google::Cloud::Tasks::V2beta3::CloudTasks::RunTask RunTask}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The task name. For example:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID/tasks/TASK_ID`
        # @!attribute [rw] response_view
        #   @return [Google::Cloud::Tasks::V2beta3::Task::View]
        #     The response_view specifies which subset of the {Google::Cloud::Tasks::V2beta3::Task Task} will be
        #     returned.
        #
        #     By default response_view is {Google::Cloud::Tasks::V2beta3::Task::View::BASIC BASIC}; not all
        #     information is retrieved by default because some data, such as
        #     payloads, might be desirable to return only when needed because
        #     of its large size or because of the sensitivity of data that it
        #     contains.
        #
        #     Authorization for {Google::Cloud::Tasks::V2beta3::Task::View::FULL FULL} requires
        #     `cloudtasks.tasks.fullView` [Google IAM](https://cloud.google.com/iam/)
        #     permission on the {Google::Cloud::Tasks::V2beta3::Task Task} resource.
        class RunTaskRequest; end
      end
    end
  end
end