# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/monitoring/dashboard/v1/metrics.proto

require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'google/monitoring/dashboard/v1/common_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/monitoring/dashboard/v1/metrics.proto", :syntax => :proto3) do
    add_message "google.monitoring.dashboard.v1.TimeSeriesQuery" do
      optional :unit_override, :string, 5
      oneof :source do
        optional :time_series_filter, :message, 1, "google.monitoring.dashboard.v1.TimeSeriesFilter"
        optional :time_series_filter_ratio, :message, 2, "google.monitoring.dashboard.v1.TimeSeriesFilterRatio"
      end
    end
    add_message "google.monitoring.dashboard.v1.TimeSeriesFilter" do
      optional :filter, :string, 1
      optional :aggregation, :message, 2, "google.monitoring.dashboard.v1.Aggregation"
      oneof :output_filter do
        optional :pick_time_series_filter, :message, 4, "google.monitoring.dashboard.v1.PickTimeSeriesFilter"
        optional :statistical_time_series_filter, :message, 5, "google.monitoring.dashboard.v1.StatisticalTimeSeriesFilter"
      end
    end
    add_message "google.monitoring.dashboard.v1.TimeSeriesFilterRatio" do
      optional :numerator, :message, 1, "google.monitoring.dashboard.v1.TimeSeriesFilterRatio.RatioPart"
      optional :denominator, :message, 2, "google.monitoring.dashboard.v1.TimeSeriesFilterRatio.RatioPart"
      optional :secondary_aggregation, :message, 3, "google.monitoring.dashboard.v1.Aggregation"
      oneof :output_filter do
        optional :pick_time_series_filter, :message, 4, "google.monitoring.dashboard.v1.PickTimeSeriesFilter"
        optional :statistical_time_series_filter, :message, 5, "google.monitoring.dashboard.v1.StatisticalTimeSeriesFilter"
      end
    end
    add_message "google.monitoring.dashboard.v1.TimeSeriesFilterRatio.RatioPart" do
      optional :filter, :string, 1
      optional :aggregation, :message, 2, "google.monitoring.dashboard.v1.Aggregation"
    end
    add_message "google.monitoring.dashboard.v1.Threshold" do
      optional :label, :string, 1
      optional :value, :double, 2
      optional :color, :enum, 3, "google.monitoring.dashboard.v1.Threshold.Color"
      optional :direction, :enum, 4, "google.monitoring.dashboard.v1.Threshold.Direction"
    end
    add_enum "google.monitoring.dashboard.v1.Threshold.Color" do
      value :COLOR_UNSPECIFIED, 0
      value :YELLOW, 4
      value :RED, 6
    end
    add_enum "google.monitoring.dashboard.v1.Threshold.Direction" do
      value :DIRECTION_UNSPECIFIED, 0
      value :ABOVE, 1
      value :BELOW, 2
    end
    add_enum "google.monitoring.dashboard.v1.SparkChartType" do
      value :SPARK_CHART_TYPE_UNSPECIFIED, 0
      value :SPARK_LINE, 1
      value :SPARK_BAR, 2
    end
  end
end

module Google
  module Cloud
    module Monitoring
      module Dashboard
        module V1
          TimeSeriesQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.TimeSeriesQuery").msgclass
          TimeSeriesFilter = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.TimeSeriesFilter").msgclass
          TimeSeriesFilterRatio = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.TimeSeriesFilterRatio").msgclass
          TimeSeriesFilterRatio::RatioPart = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.TimeSeriesFilterRatio.RatioPart").msgclass
          Threshold = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.Threshold").msgclass
          Threshold::Color = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.Threshold.Color").enummodule
          Threshold::Direction = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.Threshold.Direction").enummodule
          SparkChartType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.dashboard.v1.SparkChartType").enummodule
        end
      end
    end
  end
end
