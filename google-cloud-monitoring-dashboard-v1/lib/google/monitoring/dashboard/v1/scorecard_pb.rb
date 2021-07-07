# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/monitoring/dashboard/v1/scorecard.proto

require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'google/monitoring/dashboard/v1/metrics_pb'
require 'google/protobuf/duration_pb'
require 'google/protobuf/empty_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/monitoring/dashboard/v1/scorecard.proto", :syntax => :proto3) do
    add_message "google.monitoring.dashboard.v1.Scorecard" do
      optional :time_series_query, :message, 1, "google.monitoring.dashboard.v1.TimeSeriesQuery"
      repeated :thresholds, :message, 6, "google.monitoring.dashboard.v1.Threshold"
      oneof :data_view do
        optional :gauge_view, :message, 4, "google.monitoring.dashboard.v1.Scorecard.GaugeView"
        optional :spark_chart_view, :message, 5, "google.monitoring.dashboard.v1.Scorecard.SparkChartView"
      end
    end
    add_message "google.monitoring.dashboard.v1.Scorecard.GaugeView" do
      optional :lower_bound, :double, 1
      optional :upper_bound, :double, 2
    end
    add_message "google.monitoring.dashboard.v1.Scorecard.SparkChartView" do
      optional :spark_chart_type, :enum, 1, "google.monitoring.dashboard.v1.SparkChartType"
      optional :min_alignment_period, :message, 2, "google.protobuf.Duration"
    end
  end
end

module Google
  module Cloud
    module Monitoring
      module Dashboard
        module V1
          Scorecard = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.Scorecard").msgclass
          Scorecard::GaugeView = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.Scorecard.GaugeView").msgclass
          Scorecard::SparkChartView = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.Scorecard.SparkChartView").msgclass
        end
      end
    end
  end
end
