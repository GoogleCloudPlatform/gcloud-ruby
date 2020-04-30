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

"""This script is used to synthesize generated parts of this library."""

import synthtool as s
import synthtool.gcp as gcp
import synthtool.languages.ruby as ruby
import logging

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICMicrogenerator()
library = gapic.ruby_library(
    "tasks", "v2",
    generator_args={
        "ruby-cloud-gem-name": "google-cloud-tasks",
        "ruby-cloud-title": "Cloud Tasks",
        "ruby-cloud-description": "Cloud Tasks is a fully managed service that allows you to manage the execution, dispatch and delivery of a large number of distributed tasks. You can asynchronously perform work outside of a user request. Your tasks can be executed on App Engine or any arbitrary HTTP endpoint.",
        "ruby-cloud-env-prefix": "TASKS",
        "ruby-cloud-wrapper-of": "v2:0.0;v2beta2:0.0;v2beta3:0.0",
        "ruby-cloud-product-url": "https://cloud.google.com/tasks",
        "ruby-cloud-api-id": "cloudtasks",
        "ruby-cloud-migration-version": "2.0",
    }
)

s.copy(library, merge=ruby.global_merge)
