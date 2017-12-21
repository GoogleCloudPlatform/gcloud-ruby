# Copyright 2017 Google LLC
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
    # rubocop:disable LineLength

    ##
    # # Ruby Client for Google Cloud Dataproc API ([Alpha](https://github.com/GoogleCloudPlatform/google-cloud-ruby#versioning))
    #
    # [Google Cloud Dataproc API][Product Documentation]:
    # Manages Hadoop-based clusters and jobs on Google Cloud Platform.
    # - [Product Documentation][]
    #
    # ## Quick Start
    # In order to use this library, you first need to go through the following
    # steps:
    #
    # 1. [Select or create a Cloud Platform project.](https://console.cloud.google.com/project)
    # 2. [Enable billing for your project.](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
    # 3. [Enable the Google Cloud Dataproc API.](https://console.cloud.google.com/apis/api/dataproc)
    # 4. [Setup Authentication.](https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud/master/guides/authentication)
    #
    # ### Installation
    # ```
    # $ gem install google-cloud-dataproc
    # ```
    #
    # ### Preview
    # #### ClusterControllerClient
    # ```rb
    # require "google/cloud/dataproc"
    #
    # cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new
    # project_id_2 = project_id
    # region = "global"
    #
    # # Iterate over all results.
    # cluster_controller_client.list_clusters(project_id_2, region).each do |element|
    #   # Process element.
    # end
    #
    # # Or iterate over results one page at a time.
    # cluster_controller_client.list_clusters(project_id_2, region).each_page do |page|
    #   # Process each page at a time.
    #   page.each do |element|
    #     # Process element.
    #   end
    # end
    # ```
    #
    # ### Next Steps
    # - Read the [Google Cloud Dataproc API Product documentation][Product Documentation]
    #   to learn more about the product and see How-to Guides.
    # - View this [repository's main README](https://github.com/GoogleCloudPlatform/google-cloud-ruby/blob/master/README.md)
    #   to see the full list of Cloud APIs that we cover.
    #
    # [Product Documentation]: https://cloud.google.com/dataproc
    #
    #
    module Dataproc
      module V1
      end
    end
  end
end