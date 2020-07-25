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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Cloud
    module Dialogflow
      module V2
        # You can create multiple versions of your agent and publish them to separate
        # environments.
        #
        # When you edit an agent, you are editing the draft agent. At any point, you
        # can save the draft agent as an agent version, which is an immutable snapshot
        # of your agent.
        #
        # When you save the draft agent, it is published to the default environment.
        # When you create agent versions, you can publish them to custom environments.
        # You can create a variety of custom environments for:
        #
        # - testing
        # - development
        # - production
        # - etc.
        #
        # For more information, see the [versions and environments
        # guide](https://cloud.google.com/dialogflow/docs/agents-versions).
        # @!attribute [r] name
        #   @return [::String]
        #     Output only. The unique identifier of this agent environment.
        #     Format: `projects/<Project ID>/agent/environments/<Environment ID>`.
        #     For Environment ID, "-" is reserved for 'draft' environment.
        # @!attribute [rw] description
        #   @return [::String]
        #     Optional. The developer-provided description for this environment.
        #     The maximum length is 500 characters. If exceeded, the request is rejected.
        # @!attribute [rw] agent_version
        #   @return [::String]
        #     Optional. The agent version loaded into this environment.
        #     Format: `projects/<Project ID>/agent/versions/<Version ID>`.
        # @!attribute [r] state
        #   @return [::Google::Cloud::Dialogflow::V2::Environment::State]
        #     Output only. The state of this environment. This field is read-only, i.e., it cannot be
        #     set by create and update methods.
        # @!attribute [r] update_time
        #   @return [::Google::Protobuf::Timestamp]
        #     Output only. The last update time of this environment. This field is read-only, i.e., it
        #     cannot be set by create and update methods.
        class Environment
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # Represents an environment state. When an environment is pointed to a new
          # agent version, the environment is temporarily set to the `LOADING` state.
          # During that time, the environment keeps on serving the previous version of
          # the agent. After the new agent version is done loading, the environment is
          # set back to the `RUNNING` state.
          module State
            # Not specified. This value is not used.
            STATE_UNSPECIFIED = 0

            # Stopped.
            STOPPED = 1

            # Loading.
            LOADING = 2

            # Running.
            RUNNING = 3
          end
        end

        # The request message for {::Google::Cloud::Dialogflow::V2::Environments::Client#list_environments Environments.ListEnvironments}.
        # @!attribute [rw] parent
        #   @return [::String]
        #     Required. The agent to list all environments from.
        #     Format: `projects/<Project ID>/agent`.
        # @!attribute [rw] page_size
        #   @return [::Integer]
        #     Optional. The maximum number of items to return in a single page. By default 100 and
        #     at most 1000.
        # @!attribute [rw] page_token
        #   @return [::String]
        #     Optional. The next_page_token value returned from a previous list request.
        class ListEnvironmentsRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The response message for {::Google::Cloud::Dialogflow::V2::Environments::Client#list_environments Environments.ListEnvironments}.
        # @!attribute [rw] environments
        #   @return [::Array<::Google::Cloud::Dialogflow::V2::Environment>]
        #     The list of agent environments. There will be a maximum number of items
        #     returned based on the page_size field in the request.
        # @!attribute [rw] next_page_token
        #   @return [::String]
        #     Token to retrieve the next page of results, or empty if there are no
        #     more results in the list.
        class ListEnvironmentsResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end
    end
  end
end
