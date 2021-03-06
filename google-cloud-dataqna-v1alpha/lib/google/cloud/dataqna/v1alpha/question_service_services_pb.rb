# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/dataqna/v1alpha/question_service.proto for package 'Google.Cloud.DataQnA.V1alpha'
# Original file comments:
# Copyright 2020 Google LLC
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
require 'google/cloud/dataqna/v1alpha/question_service_pb'

module Google
  module Cloud
    module DataQnA
      module V1alpha
        module QuestionService
          # Service to interpret natural language queries.
          # The service allows to create `Question` resources that are interpreted and
          # are filled with one or more interpretations if the question could be
          # interpreted. Once a `Question` resource is created and has at least one
          # interpretation, an interpretation can be chosen for execution, which
          # triggers a query to the backend (for BigQuery, it will create a job).
          # Upon successful execution of that interpretation, backend specific
          # information will be returned so that the client can retrieve the results
          # from the backend.
          #
          # The `Question` resources are named `projects/*/locations/*/questions/*`.
          #
          # The `Question` resource has a singletion sub-resource `UserFeedback` named
          # `projects/*/locations/*/questions/*/userFeedback`, which allows access to
          # user feedback.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.dataqna.v1alpha.QuestionService'

            # Gets a previously created question.
            rpc :GetQuestion, ::Google::Cloud::DataQnA::V1alpha::GetQuestionRequest, ::Google::Cloud::DataQnA::V1alpha::Question
            # Creates a question.
            rpc :CreateQuestion, ::Google::Cloud::DataQnA::V1alpha::CreateQuestionRequest, ::Google::Cloud::DataQnA::V1alpha::Question
            # Executes an interpretation.
            rpc :ExecuteQuestion, ::Google::Cloud::DataQnA::V1alpha::ExecuteQuestionRequest, ::Google::Cloud::DataQnA::V1alpha::Question
            # Gets previously created user feedback.
            rpc :GetUserFeedback, ::Google::Cloud::DataQnA::V1alpha::GetUserFeedbackRequest, ::Google::Cloud::DataQnA::V1alpha::UserFeedback
            # Updates user feedback. This creates user feedback if there was none before
            # (upsert).
            rpc :UpdateUserFeedback, ::Google::Cloud::DataQnA::V1alpha::UpdateUserFeedbackRequest, ::Google::Cloud::DataQnA::V1alpha::UserFeedback
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
