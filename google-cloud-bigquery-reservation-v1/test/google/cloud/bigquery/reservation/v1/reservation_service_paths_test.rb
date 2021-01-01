# frozen_string_literal: true

# Copyright 2021 Google LLC
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

require "helper"

require "gapic/grpc/service_stub"

require "google/cloud/bigquery/reservation/v1/reservation_service"

class ::Google::Cloud::Bigquery::Reservation::V1::ReservationService::ClientPathsTest < Minitest::Test
  def test_assignment_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Bigquery::Reservation::V1::ReservationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.assignment_path project: "value0", location: "value1", reservation: "value2", assignment: "value3"
      assert_equal "projects/value0/locations/value1/reservations/value2/assignments/value3", path
    end
  end

  def test_bi_reservation_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Bigquery::Reservation::V1::ReservationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.bi_reservation_path project: "value0", location: "value1"
      assert_equal "projects/value0/locations/value1/bireservation", path
    end
  end

  def test_capacity_commitment_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Bigquery::Reservation::V1::ReservationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.capacity_commitment_path project: "value0", location: "value1", capacity_commitment: "value2"
      assert_equal "projects/value0/locations/value1/capacityCommitments/value2", path
    end
  end

  def test_location_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Bigquery::Reservation::V1::ReservationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.location_path project: "value0", location: "value1"
      assert_equal "projects/value0/locations/value1", path
    end
  end

  def test_reservation_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Bigquery::Reservation::V1::ReservationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.reservation_path project: "value0", location: "value1", reservation: "value2"
      assert_equal "projects/value0/locations/value1/reservations/value2", path
    end
  end
end
