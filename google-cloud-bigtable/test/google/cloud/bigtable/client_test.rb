# Copyright 2018 Google LLC
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

require 'helper'
require 'google/cloud/bigtable/instance_set'

describe Google::Cloud::Bigtable::Client do
  before do
    project_id = "project_#{Time.now.to_i}"
    @config = Google::Cloud::Bigtable::Config.new project_id
  end

  describe '#instances' do
    it 'should return object of InstanceSet' do
      client = Google::Cloud::Bigtable::Client.new @config
      assert_instance_of Google::Cloud::Bigtable::InstanceSet, client.instances
    end
  end
end
