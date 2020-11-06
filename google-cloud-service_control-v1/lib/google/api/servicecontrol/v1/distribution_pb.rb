# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/api/servicecontrol/v1/distribution.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/api/servicecontrol/v1/distribution.proto", :syntax => :proto3) do
    add_message "google.api.servicecontrol.v1.Distribution" do
      optional :count, :int64, 1
      optional :mean, :double, 2
      optional :minimum, :double, 3
      optional :maximum, :double, 4
      optional :sum_of_squared_deviation, :double, 5
      repeated :bucket_counts, :int64, 6
      oneof :bucket_option do
        optional :linear_buckets, :message, 7, "google.api.servicecontrol.v1.Distribution.LinearBuckets"
        optional :exponential_buckets, :message, 8, "google.api.servicecontrol.v1.Distribution.ExponentialBuckets"
        optional :explicit_buckets, :message, 9, "google.api.servicecontrol.v1.Distribution.ExplicitBuckets"
      end
    end
    add_message "google.api.servicecontrol.v1.Distribution.LinearBuckets" do
      optional :num_finite_buckets, :int32, 1
      optional :width, :double, 2
      optional :offset, :double, 3
    end
    add_message "google.api.servicecontrol.v1.Distribution.ExponentialBuckets" do
      optional :num_finite_buckets, :int32, 1
      optional :growth_factor, :double, 2
      optional :scale, :double, 3
    end
    add_message "google.api.servicecontrol.v1.Distribution.ExplicitBuckets" do
      repeated :bounds, :double, 1
    end
  end
end

module Google
  module Cloud
    module ServiceControl
      module V1
        Distribution = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.api.servicecontrol.v1.Distribution").msgclass
        Distribution::LinearBuckets = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.api.servicecontrol.v1.Distribution.LinearBuckets").msgclass
        Distribution::ExponentialBuckets = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.api.servicecontrol.v1.Distribution.ExponentialBuckets").msgclass
        Distribution::ExplicitBuckets = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.api.servicecontrol.v1.Distribution.ExplicitBuckets").msgclass
      end
    end
  end
end
