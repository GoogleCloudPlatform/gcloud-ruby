# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/devtools/clouddebugger/v2/controller.proto for package 'Google.Cloud.Debugger.V2'
# Original file comments:
# Copyright 2019 Google LLC.
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
#

require 'grpc'
require 'google/devtools/clouddebugger/v2/controller_pb'

module Google
  module Cloud
    module Debugger
      module V2
        module Controller2
          # The Controller service provides the API for orchestrating a collection of
          # debugger agents to perform debugging tasks. These agents are each attached
          # to a process of an application which may include one or more replicas.
          #
          # The debugger agents register with the Controller to identify the application
          # being debugged, the Debuggee. All agents that register with the same data,
          # represent the same Debuggee, and are assigned the same `debuggee_id`.
          #
          # The debugger agents call the Controller to retrieve  the list of active
          # Breakpoints. Agents with the same `debuggee_id` get the same breakpoints
          # list. An agent that can fulfill the breakpoint request updates the
          # Controller with the breakpoint result. The controller selects the first
          # result received and discards the rest of the results.
          # Agents that poll again for active breakpoints will no longer have
          # the completed breakpoint in the list and should remove that breakpoint from
          # their attached process.
          #
          # The Controller service does not provide a way to retrieve the results of
          # a completed breakpoint. This functionality is available using the Debugger
          # service.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.devtools.clouddebugger.v2.Controller2'

            # Registers the debuggee with the controller service.
            #
            # All agents attached to the same application must call this method with
            # exactly the same request content to get back the same stable `debuggee_id`.
            # Agents should call this method again whenever `google.rpc.Code.NOT_FOUND`
            # is returned from any controller method.
            #
            # This protocol allows the controller service to disable debuggees, recover
            # from data loss, or change the `debuggee_id` format. Agents must handle
            # `debuggee_id` value changing upon re-registration.
            rpc :RegisterDebuggee, Google::Cloud::Debugger::V2::RegisterDebuggeeRequest, Google::Cloud::Debugger::V2::RegisterDebuggeeResponse
            # Returns the list of all active breakpoints for the debuggee.
            #
            # The breakpoint specification (`location`, `condition`, and `expressions`
            # fields) is semantically immutable, although the field values may
            # change. For example, an agent may update the location line number
            # to reflect the actual line where the breakpoint was set, but this
            # doesn't change the breakpoint semantics.
            #
            # This means that an agent does not need to check if a breakpoint has changed
            # when it encounters the same breakpoint on a successive call.
            # Moreover, an agent should remember the breakpoints that are completed
            # until the controller removes them from the active list to avoid
            # setting those breakpoints again.
            rpc :ListActiveBreakpoints, Google::Cloud::Debugger::V2::ListActiveBreakpointsRequest, Google::Cloud::Debugger::V2::ListActiveBreakpointsResponse
            # Updates the breakpoint state or mutable fields.
            # The entire Breakpoint message must be sent back to the controller service.
            #
            # Updates to active breakpoint fields are only allowed if the new value
            # does not change the breakpoint specification. Updates to the `location`,
            # `condition` and `expressions` fields should not alter the breakpoint
            # semantics. These may only make changes such as canonicalizing a value
            # or snapping the location to the correct line of code.
            rpc :UpdateActiveBreakpoint, Google::Cloud::Debugger::V2::UpdateActiveBreakpointRequest, Google::Cloud::Debugger::V2::UpdateActiveBreakpointResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
