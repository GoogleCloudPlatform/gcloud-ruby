# frozen_string_literal: true

# Copyright 2020 Google LLC
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


module Google
  module Analytics
    module Data
      module V1alpha
        # The dimensions and metrics currently accepted in reporting methods.
        # @!attribute [rw] name
        #   @return [::String]
        #     Resource name of this metadata.
        # @!attribute [rw] dimensions
        #   @return [::Array<::Google::Analytics::Data::V1alpha::DimensionMetadata>]
        #     The dimensions descriptions.
        # @!attribute [rw] metrics
        #   @return [::Array<::Google::Analytics::Data::V1alpha::MetricMetadata>]
        #     The metric descriptions.
        class Metadata
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The request to generate a report.
        # @!attribute [rw] entity
        #   @return [::Google::Analytics::Data::V1alpha::Entity]
        #     A property whose events are tracked. Within a batch request, this entity
        #     should either be unspecified or consistent with the batch-level entity.
        # @!attribute [rw] dimensions
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Dimension>]
        #     The dimensions requested and displayed.
        # @!attribute [rw] metrics
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Metric>]
        #     The metrics requested and displayed.
        # @!attribute [rw] date_ranges
        #   @return [::Array<::Google::Analytics::Data::V1alpha::DateRange>]
        #     Date ranges of data to read. If multiple date ranges are requested, each
        #     response row will contain a zero based date range index. If two date
        #     ranges overlap, the event data for the overlapping days is included in the
        #     response rows for both date ranges. In a cohort request, this `dateRanges`
        #     must be unspecified.
        # @!attribute [rw] offset
        #   @return [::Integer]
        #     The row count of the start row. The first row is counted as row 0.
        # @!attribute [rw] limit
        #   @return [::Integer]
        #     The number of rows to return. If unspecified, 10 rows are returned. If
        #     -1, all rows are returned.
        # @!attribute [rw] metric_aggregations
        #   @return [::Array<::Google::Analytics::Data::V1alpha::MetricAggregation>]
        #     Aggregation of metrics. Aggregated metric values will be shown in rows
        #     where the dimension_values are set to "RESERVED_(MetricAggregation)".
        # @!attribute [rw] dimension_filter
        #   @return [::Google::Analytics::Data::V1alpha::FilterExpression]
        #     The filter clause of dimensions. Dimensions must be requested to be used in
        #     this filter. Metrics cannot be used in this filter.
        # @!attribute [rw] metric_filter
        #   @return [::Google::Analytics::Data::V1alpha::FilterExpression]
        #     The filter clause of metrics. Applied at post aggregation phase, similar to
        #     SQL having-clause. Metrics must be requested to be used in this filter.
        #     Dimensions cannot be used in this filter.
        # @!attribute [rw] order_bys
        #   @return [::Array<::Google::Analytics::Data::V1alpha::OrderBy>]
        #     Specifies how rows are ordered in the response.
        # @!attribute [rw] currency_code
        #   @return [::String]
        #     A currency code in ISO4217 format, such as "AED", "USD", "JPY".
        #     If the field is empty, the report uses the entity's default currency.
        # @!attribute [rw] cohort_spec
        #   @return [::Google::Analytics::Data::V1alpha::CohortSpec]
        #     Cohort group associated with this request. If there is a cohort group
        #     in the request the 'cohort' dimension must be present.
        # @!attribute [rw] keep_empty_rows
        #   @return [::Boolean]
        #     If false or unspecified, each row with all metrics equal to 0 will not be
        #     returned. If true, these rows will be returned if they are not separately
        #     removed by a filter.
        # @!attribute [rw] return_property_quota
        #   @return [::Boolean]
        #     Toggles whether to return the current state of this Analytics Property's
        #     quota. Quota is returned in [PropertyQuota](#PropertyQuota).
        class RunReportRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The response report table corresponding to a request.
        # @!attribute [rw] dimension_headers
        #   @return [::Array<::Google::Analytics::Data::V1alpha::DimensionHeader>]
        #     Describes dimension columns. The number of DimensionHeaders and ordering of
        #     DimensionHeaders matches the dimensions present in rows.
        # @!attribute [rw] metric_headers
        #   @return [::Array<::Google::Analytics::Data::V1alpha::MetricHeader>]
        #     Describes metric columns. The number of MetricHeaders and ordering of
        #     MetricHeaders matches the metrics present in rows.
        # @!attribute [rw] rows
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Row>]
        #     Rows of dimension value combinations and metric values in the report.
        # @!attribute [rw] totals
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Row>]
        #     If requested, the totaled values of metrics.
        # @!attribute [rw] maximums
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Row>]
        #     If requested, the maximum values of metrics.
        # @!attribute [rw] minimums
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Row>]
        #     If requested, the minimum values of metrics.
        # @!attribute [rw] row_count
        #   @return [::Integer]
        #     The total number of rows in the query result, regardless of the number of
        #     rows returned in the response. For example if a query returns 175 rows and
        #     includes limit = 50 in the API request, the response will contain row_count
        #     = 175 but only 50 rows.
        # @!attribute [rw] metadata
        #   @return [::Google::Analytics::Data::V1alpha::ResponseMetaData]
        #     Metadata for the report.
        # @!attribute [rw] property_quota
        #   @return [::Google::Analytics::Data::V1alpha::PropertyQuota]
        #     This Analytics Property's quota state including this request.
        class RunReportResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The request to generate a pivot report.
        # @!attribute [rw] entity
        #   @return [::Google::Analytics::Data::V1alpha::Entity]
        #     A property whose events are tracked. Within a batch request, this entity
        #     should either be unspecified or consistent with the batch-level entity.
        # @!attribute [rw] dimensions
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Dimension>]
        #     The dimensions requested. All defined dimensions must be used by one of the
        #     following: dimension_expression, dimension_filter, pivots, order_bys.
        # @!attribute [rw] metrics
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Metric>]
        #     The metrics requested, at least one metric needs to be specified. All
        #     defined metrics must be used by one of the following: metric_expression,
        #     metric_filter, order_bys.
        # @!attribute [rw] dimension_filter
        #   @return [::Google::Analytics::Data::V1alpha::FilterExpression]
        #     The filter clause of dimensions. Dimensions must be requested to be used in
        #     this filter. Metrics cannot be used in this filter.
        # @!attribute [rw] metric_filter
        #   @return [::Google::Analytics::Data::V1alpha::FilterExpression]
        #     The filter clause of metrics. Applied at post aggregation phase, similar to
        #     SQL having-clause. Metrics must be requested to be used in this filter.
        #     Dimensions cannot be used in this filter.
        # @!attribute [rw] pivots
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Pivot>]
        #     Describes the visual format of the report's dimensions in columns or rows.
        #     The union of the fieldNames (dimension names) in all pivots must be a
        #     subset of dimension names defined in Dimensions. No two pivots can share a
        #     dimension. A dimension is only visible if it appears in a pivot.
        # @!attribute [rw] date_ranges
        #   @return [::Array<::Google::Analytics::Data::V1alpha::DateRange>]
        #     The date range to retrieve event data for the report. If multiple date
        #     ranges are specified, event data from each date range is used in the
        #     report. A special dimension with field name "dateRange" can be included in
        #     a Pivot's field names; if included, the report compares between date
        #     ranges. In a cohort request, this `dateRanges` must be unspecified.
        # @!attribute [rw] currency_code
        #   @return [::String]
        #     A currency code in ISO4217 format, such as "AED", "USD", "JPY".
        #     If the field is empty, the report uses the entity's default currency.
        # @!attribute [rw] cohort_spec
        #   @return [::Google::Analytics::Data::V1alpha::CohortSpec]
        #     Cohort group associated with this request. If there is a cohort group
        #     in the request the 'cohort' dimension must be present.
        # @!attribute [rw] keep_empty_rows
        #   @return [::Boolean]
        #     If false or unspecified, each row with all metrics equal to 0 will not be
        #     returned. If true, these rows will be returned if they are not separately
        #     removed by a filter.
        # @!attribute [rw] return_property_quota
        #   @return [::Boolean]
        #     Toggles whether to return the current state of this Analytics Property's
        #     quota. Quota is returned in [PropertyQuota](#PropertyQuota).
        class RunPivotReportRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The response pivot report table corresponding to a pivot request.
        # @!attribute [rw] pivot_headers
        #   @return [::Array<::Google::Analytics::Data::V1alpha::PivotHeader>]
        #     Summarizes the columns and rows created by a pivot. Each pivot in the
        #     request produces one header in the response. If we have a request like
        #     this:
        #
        #         "pivots": [{
        #           "fieldNames": ["country",
        #             "city"]
        #         },
        #         {
        #           "fieldNames": "eventName"
        #         }]
        #
        #     We will have the following `pivotHeaders` in the response:
        #
        #         "pivotHeaders" : [{
        #           "dimensionHeaders": [{
        #             "dimensionValues": [
        #                { "value": "United Kingdom" },
        #                { "value": "London" }
        #              ]
        #           },
        #           {
        #             "dimensionValues": [
        #             { "value": "Japan" },
        #             { "value": "Osaka" }
        #             ]
        #           }]
        #         },
        #         {
        #           "dimensionHeaders": [{
        #             "dimensionValues": [{ "value": "session_start" }]
        #           },
        #           {
        #             "dimensionValues": [{ "value": "scroll" }]
        #           }]
        #         }]
        # @!attribute [rw] dimension_headers
        #   @return [::Array<::Google::Analytics::Data::V1alpha::DimensionHeader>]
        #     Describes dimension columns. The number of DimensionHeaders and ordering of
        #     DimensionHeaders matches the dimensions present in rows.
        # @!attribute [rw] metric_headers
        #   @return [::Array<::Google::Analytics::Data::V1alpha::MetricHeader>]
        #     Describes metric columns. The number of MetricHeaders and ordering of
        #     MetricHeaders matches the metrics present in rows.
        # @!attribute [rw] rows
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Row>]
        #     Rows of dimension value combinations and metric values in the report.
        # @!attribute [rw] aggregates
        #   @return [::Array<::Google::Analytics::Data::V1alpha::Row>]
        #     Aggregation of metric values. Can be totals, minimums, or maximums. The
        #     returned aggregations are controlled by the metric_aggregations in the
        #     pivot. The type of aggregation returned in each row is shown by the
        #     dimension_values which are set to "RESERVED_<MetricAggregation>".
        # @!attribute [rw] metadata
        #   @return [::Google::Analytics::Data::V1alpha::ResponseMetaData]
        #     Metadata for the report.
        # @!attribute [rw] property_quota
        #   @return [::Google::Analytics::Data::V1alpha::PropertyQuota]
        #     This Analytics Property's quota state including this request.
        class RunPivotReportResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The batch request containing multiple report requests.
        # @!attribute [rw] entity
        #   @return [::Google::Analytics::Data::V1alpha::Entity]
        #     A property whose events are tracked. This entity must be specified for the
        #     batch. The entity within RunReportRequest may either be unspecified or
        #     consistent with this entity.
        # @!attribute [rw] requests
        #   @return [::Array<::Google::Analytics::Data::V1alpha::RunReportRequest>]
        #     Individual requests. Each request has a separate report response. Each
        #     batch request is allowed up to 5 requests.
        class BatchRunReportsRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The batch response containing multiple reports.
        # @!attribute [rw] reports
        #   @return [::Array<::Google::Analytics::Data::V1alpha::RunReportResponse>]
        #     Individual responses. Each response has a separate report request.
        class BatchRunReportsResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The batch request containing multiple pivot report requests.
        # @!attribute [rw] entity
        #   @return [::Google::Analytics::Data::V1alpha::Entity]
        #     A property whose events are tracked. This entity must be specified for the
        #     batch. The entity within RunPivotReportRequest may either be unspecified or
        #     consistent with this entity.
        # @!attribute [rw] requests
        #   @return [::Array<::Google::Analytics::Data::V1alpha::RunPivotReportRequest>]
        #     Individual requests. Each request has a separate pivot report response.
        #     Each batch request is allowed up to 5 requests.
        class BatchRunPivotReportsRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The batch response containing multiple pivot reports.
        # @!attribute [rw] pivot_reports
        #   @return [::Array<::Google::Analytics::Data::V1alpha::RunPivotReportResponse>]
        #     Individual responses. Each response has a separate pivot report request.
        class BatchRunPivotReportsResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Request for the universal dimension and metric metadata.
        class GetUniversalMetadataRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The dimensions and metrics currently accepted in reporting methods.
        # @!attribute [rw] dimensions
        #   @return [::Array<::Google::Analytics::Data::V1alpha::DimensionMetadata>]
        #     The dimensions descriptions.
        # @!attribute [rw] metrics
        #   @return [::Array<::Google::Analytics::Data::V1alpha::MetricMetadata>]
        #     The metric descriptions.
        class UniversalMetadata
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Request for a property's dimension and metric metadata.
        # @!attribute [rw] name
        #   @return [::String]
        #     Required. The resource name of the metadata to retrieve. This name field is
        #     specified in the URL path and not URL parameters. Property is a numeric
        #     Google Analytics 4 (GA4) Property identifier.
        #
        #     Example: properties/1234/metadata
        class GetMetadataRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end
    end
  end
end
