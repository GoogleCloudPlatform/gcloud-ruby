# Copyright 2019 Google LLC
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
  module Monitoring
    module Dashboard
      module V1
        # TimeSeriesQuery collects the set of supported methods for querying time
        # series data from the Stackdriver metrics API.
        # @!attribute [rw] time_series_filter
        #   @return [Google::Monitoring::Dashboard::V1::TimeSeriesFilter]
        #     Filter parameters to fetch time series.
        # @!attribute [rw] time_series_filter_ratio
        #   @return [Google::Monitoring::Dashboard::V1::TimeSeriesFilterRatio]
        #     Parameters to fetch a ratio between two time series filters.
        # @!attribute [rw] unit_override
        #   @return [String]
        #     The unit of data contained in fetched time series. If non-empty, this
        #     unit will override any unit that accompanies fetched data. The format is
        #     the same as the
        #     [`unit`](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.metricDescriptors)
        #     field in `MetricDescriptor`.
        class TimeSeriesQuery; end

        # A filter that defines a subset of time series data that is displayed in a
        # widget. Time series data is fetched using the
        # [`ListTimeSeries`](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.timeSeries/list)
        # method.
        # @!attribute [rw] filter
        #   @return [String]
        #     Required. The [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters) that identifies the
        #     metric types, resources, and projects to query.
        # @!attribute [rw] aggregation
        #   @return [Google::Monitoring::Dashboard::V1::Aggregation]
        #     By default, the raw time series data is returned.
        #     Use this field to combine multiple time series for different views of the
        #     data.
        # @!attribute [rw] pick_time_series_filter
        #   @return [Google::Monitoring::Dashboard::V1::PickTimeSeriesFilter]
        #     Ranking based time series filter.
        # @!attribute [rw] statistical_time_series_filter
        #   @return [Google::Monitoring::Dashboard::V1::StatisticalTimeSeriesFilter]
        #     Statistics based time series filter.
        class TimeSeriesFilter; end

        # A pair of time series filters that define a ratio computation. The output
        # time series is the pair-wise division of each aligned element from the
        # numerator and denominator time series.
        # @!attribute [rw] numerator
        #   @return [Google::Monitoring::Dashboard::V1::TimeSeriesFilterRatio::RatioPart]
        #     The numerator of the ratio.
        # @!attribute [rw] denominator
        #   @return [Google::Monitoring::Dashboard::V1::TimeSeriesFilterRatio::RatioPart]
        #     The denominator of the ratio.
        # @!attribute [rw] secondary_aggregation
        #   @return [Google::Monitoring::Dashboard::V1::Aggregation]
        #     Apply a second aggregation after the ratio is computed.
        # @!attribute [rw] pick_time_series_filter
        #   @return [Google::Monitoring::Dashboard::V1::PickTimeSeriesFilter]
        #     Ranking based time series filter.
        # @!attribute [rw] statistical_time_series_filter
        #   @return [Google::Monitoring::Dashboard::V1::StatisticalTimeSeriesFilter]
        #     Statistics based time series filter.
        class TimeSeriesFilterRatio
          # Describes a query to build the numerator or denominator of a
          # TimeSeriesFilterRatio.
          # @!attribute [rw] filter
          #   @return [String]
          #     Required. The [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters) that identifies the
          #     metric types, resources, and projects to query.
          # @!attribute [rw] aggregation
          #   @return [Google::Monitoring::Dashboard::V1::Aggregation]
          #     By default, the raw time series data is returned.
          #     Use this field to combine multiple time series for different views of the
          #     data.
          class RatioPart; end
        end

        # Defines a threshold for categorizing time series values.
        # @!attribute [rw] label
        #   @return [String]
        #     A label for the threshold.
        # @!attribute [rw] value
        #   @return [Float]
        #     The value of the threshold. The value should be defined in the native scale
        #     of the metric.
        # @!attribute [rw] color
        #   @return [Google::Monitoring::Dashboard::V1::Threshold::Color]
        #     The state color for this threshold. Color is not allowed in a XyChart.
        # @!attribute [rw] direction
        #   @return [Google::Monitoring::Dashboard::V1::Threshold::Direction]
        #     The direction for the current threshold. Direction is not allowed in a
        #     XyChart.
        class Threshold
          # The color suggests an interpretation to the viewer when actual values cross
          # the threshold. Comments on each color provide UX guidance on how users can
          # be expected to interpret a given state color.
          module Color
            # Color is unspecified. Not allowed in well-formed requests.
            COLOR_UNSPECIFIED = 0

            # Crossing the threshold is "concerning" behavior.
            YELLOW = 4

            # Crossing the threshold is "emergency" behavior.
            RED = 6
          end

          # Whether the threshold is considered crossed by an actual value above or
          # below its threshold value.
          module Direction
            # Not allowed in well-formed requests.
            DIRECTION_UNSPECIFIED = 0

            # The threshold will be considered crossed if the actual value is above
            # the threshold value.
            ABOVE = 1

            # The threshold will be considered crossed if the actual value is below
            # the threshold value.
            BELOW = 2
          end
        end

        # Defines the possible types of spark chart supported by the `Scorecard`.
        module SparkChartType
          # Not allowed in well-formed requests.
          SPARK_CHART_TYPE_UNSPECIFIED = 0

          # The sparkline will be rendered as a small line chart.
          SPARK_LINE = 1

          # The sparkbar will be rendered as a small bar chart.
          SPARK_BAR = 2
        end
      end
    end
  end
end