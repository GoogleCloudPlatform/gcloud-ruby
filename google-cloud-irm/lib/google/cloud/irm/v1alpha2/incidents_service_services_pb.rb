# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/irm/v1alpha2/incidents_service.proto for package 'google.cloud.irm.v1alpha2'
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
require 'google/cloud/irm/v1alpha2/incidents_service_pb'

module Google
  module Cloud
    module Irm
      module V1alpha2
        module IncidentService
          # The Incident API for Incident Response & Management.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.irm.v1alpha2.IncidentService'

            # Creates a new incident.
            rpc :CreateIncident, CreateIncidentRequest, Incident
            # Returns an incident by name.
            rpc :GetIncident, GetIncidentRequest, Incident
            # Returns a list of incidents.
            # Incidents are ordered by start time, with the most recent incidents first.
            rpc :SearchIncidents, SearchIncidentsRequest, SearchIncidentsResponse
            # Updates an existing incident.
            rpc :UpdateIncident, UpdateIncidentRequest, Incident
            # Returns a list of incidents that are "similar" to the specified incident
            # or signal. This functionality is provided on a best-effort basis and the
            # definition of "similar" is subject to change.
            rpc :SearchSimilarIncidents, SearchSimilarIncidentsRequest, SearchSimilarIncidentsResponse
            # Creates an annotation on an existing incident. Only 'text/plain' and
            # 'text/markdown' annotations can be created via this method.
            rpc :CreateAnnotation, CreateAnnotationRequest, Annotation
            # Lists annotations that are part of an incident. No assumptions should be
            # made on the content-type of the annotation returned.
            rpc :ListAnnotations, ListAnnotationsRequest, ListAnnotationsResponse
            # Creates a tag on an existing incident.
            rpc :CreateTag, CreateTagRequest, Tag
            # Deletes an existing tag.
            rpc :DeleteTag, DeleteTagRequest, Google::Protobuf::Empty
            # Lists tags that are part of an incident.
            rpc :ListTags, ListTagsRequest, ListTagsResponse
            # Creates a new signal.
            rpc :CreateSignal, CreateSignalRequest, Signal
            # Lists signals that are part of an incident.
            # Signals are returned in reverse chronological order.
            rpc :SearchSignals, SearchSignalsRequest, SearchSignalsResponse
            # Finds a signal by other unique IDs.
            rpc :LookupSignal, LookupSignalRequest, Signal
            # Returns a signal by name.
            rpc :GetSignal, GetSignalRequest, Signal
            # Updates an existing signal (for example, to assign/unassign it to an
            # incident).
            rpc :UpdateSignal, UpdateSignalRequest, Signal
            # Escalates an incident.
            rpc :EscalateIncident, EscalateIncidentRequest, EscalateIncidentResponse
            # Creates a new artifact.
            rpc :CreateArtifact, CreateArtifactRequest, Artifact
            # Returns a list of artifacts for an incident.
            rpc :ListArtifacts, ListArtifactsRequest, ListArtifactsResponse
            # Updates an existing artifact.
            rpc :UpdateArtifact, UpdateArtifactRequest, Artifact
            # Deletes an existing artifact.
            rpc :DeleteArtifact, DeleteArtifactRequest, Google::Protobuf::Empty
            # Sends a summary of the shift for oncall handoff.
            rpc :SendShiftHandoff, SendShiftHandoffRequest, SendShiftHandoffResponse
            # Creates a new subscription.
            # This will fail if:
            #    a. there are too many (50) subscriptions in the incident already
            #    b. a subscription using the given channel already exists
            rpc :CreateSubscription, CreateSubscriptionRequest, Subscription
            # Updates a subscription.
            rpc :UpdateSubscription, UpdateSubscriptionRequest, Subscription
            # Returns a list of subscriptions for an incident.
            rpc :ListSubscriptions, ListSubscriptionsRequest, ListSubscriptionsResponse
            # Deletes an existing subscription.
            rpc :DeleteSubscription, DeleteSubscriptionRequest, Google::Protobuf::Empty
            # Creates a role assignment on an existing incident. Normally, the user field
            # will be set when assigning a role to oneself, and the next field will be
            # set when proposing another user as the assignee. Setting the next field
            # directly to a user other than oneself is equivalent to proposing and
            # force-assigning the role to the user.
            rpc :CreateIncidentRoleAssignment, CreateIncidentRoleAssignmentRequest, IncidentRoleAssignment
            # Deletes an existing role assignment.
            rpc :DeleteIncidentRoleAssignment, DeleteIncidentRoleAssignmentRequest, Google::Protobuf::Empty
            # Lists role assignments that are part of an incident.
            rpc :ListIncidentRoleAssignments, ListIncidentRoleAssignmentsRequest, ListIncidentRoleAssignmentsResponse
            # Starts a role handover. The proposed assignee will receive an email
            # notifying them of the assignment. This will fail if a role handover is
            # already pending.
            rpc :RequestIncidentRoleHandover, RequestIncidentRoleHandoverRequest, IncidentRoleAssignment
            # Confirms a role handover. This will fail if the 'proposed_assignee' field
            # of the IncidentRoleAssignment is not equal to the 'new_assignee' field of
            # the request. If the caller is not the new_assignee,
            # ForceIncidentRoleHandover should be used instead.
            rpc :ConfirmIncidentRoleHandover, ConfirmIncidentRoleHandoverRequest, IncidentRoleAssignment
            # Forces a role handover. This will fail if the 'proposed_assignee' field of
            # the IncidentRoleAssignment is not equal to the 'new_assignee' field of the
            # request. If the caller is the new_assignee, ConfirmIncidentRoleHandover
            # should be used instead.
            rpc :ForceIncidentRoleHandover, ForceIncidentRoleHandoverRequest, IncidentRoleAssignment
            # Cancels a role handover. This will fail if the 'proposed_assignee' field of
            # the IncidentRoleAssignment is not equal to the 'new_assignee' field of the
            # request.
            rpc :CancelIncidentRoleHandover, CancelIncidentRoleHandoverRequest, IncidentRoleAssignment
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
