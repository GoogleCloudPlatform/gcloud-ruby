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
  module Api
    # `Distribution` contains summary statistics for a population of values. It
    # optionally contains a histogram representing the distribution of those values
    # across a set of buckets.
    #
    # The summary statistics are the count, mean, sum of the squared deviation from
    # the mean, the minimum, and the maximum of the set of population of values.
    # The histogram is based on a sequence of buckets and gives a count of values
    # that fall into each bucket. The boundaries of the buckets are given either
    # explicitly or by formulas for buckets of fixed or exponentially increasing
    # widths.
    #
    # Although it is not forbidden, it is generally a bad idea to include
    # non-finite values (infinities or NaNs) in the population of values, as this
    # will render the `mean` and `sum_of_squared_deviation` fields meaningless.
    # @!attribute [rw] count
    #   @return [Integer]
    #     The number of values in the population. Must be non-negative. This value
    #     must equal the sum of the values in `bucket_counts` if a histogram is
    #     provided.
    # @!attribute [rw] mean
    #   @return [Float]
    #     The arithmetic mean of the values in the population. If `count` is zero
    #     then this field must be zero.
    # @!attribute [rw] sum_of_squared_deviation
    #   @return [Float]
    #     The sum of squared deviations from the mean of the values in the
    #     population. For values x_i this is:
    #
    #         Sum[i=1..n](https://cloud.google.com(x_i - mean)^2)
    #
    #     Knuth, "The Art of Computer Programming", Vol. 2, page 323, 3rd edition
    #     describes Welford's method for accumulating this sum in one pass.
    #
    #     If `count` is zero then this field must be zero.
    # @!attribute [rw] range
    #   @return [Google::Api::Distribution::Range]
    #     If specified, contains the range of the population values. The field
    #     must not be present if the `count` is zero.
    # @!attribute [rw] bucket_options
    #   @return [Google::Api::Distribution::BucketOptions]
    #     Defines the histogram bucket boundaries. If the distribution does not
    #     contain a histogram, then omit this field.
    # @!attribute [rw] bucket_counts
    #   @return [Array<Integer>]
    #     The number of values in each bucket of the histogram, as described in
    #     `bucket_options`. If the distribution does not have a histogram, then omit
    #     this field. If there is a histogram, then the sum of the values in
    #     `bucket_counts` must equal the value in the `count` field of the
    #     distribution.
    #
    #     If present, `bucket_counts` should contain N values, where N is the number
    #     of buckets specified in `bucket_options`. If you supply fewer than N
    #     values, the remaining values are assumed to be 0.
    #
    #     The order of the values in `bucket_counts` follows the bucket numbering
    #     schemes described for the three bucket types. The first value must be the
    #     count for the underflow bucket (number 0). The next N-2 values are the
    #     counts for the finite buckets (number 1 through N-2). The N'th value in
    #     `bucket_counts` is the count for the overflow bucket (number N-1).
    # @!attribute [rw] exemplars
    #   @return [Array<Google::Api::Distribution::Exemplar>]
    #     Must be in increasing order of `value` field.
    class Distribution
      # The range of the population values.
      # @!attribute [rw] min
      #   @return [Float]
      #     The minimum of the population values.
      # @!attribute [rw] max
      #   @return [Float]
      #     The maximum of the population values.
      class Range; end

      # `BucketOptions` describes the bucket boundaries used to create a histogram
      # for the distribution. The buckets can be in a linear sequence, an
      # exponential sequence, or each bucket can be specified explicitly.
      # `BucketOptions` does not include the number of values in each bucket.
      #
      # A bucket has an inclusive lower bound and exclusive upper bound for the
      # values that are counted for that bucket. The upper bound of a bucket must
      # be strictly greater than the lower bound. The sequence of N buckets for a
      # distribution consists of an underflow bucket (number 0), zero or more
      # finite buckets (number 1 through N - 2) and an overflow bucket (number N -
      # 1). The buckets are contiguous: the lower bound of bucket i (i > 0) is the
      # same as the upper bound of bucket i - 1. The buckets span the whole range
      # of finite values: lower bound of the underflow bucket is -infinity and the
      # upper bound of the overflow bucket is +infinity. The finite buckets are
      # so-called because both bounds are finite.
      # @!attribute [rw] linear_buckets
      #   @return [Google::Api::Distribution::BucketOptions::Linear]
      #     The linear bucket.
      # @!attribute [rw] exponential_buckets
      #   @return [Google::Api::Distribution::BucketOptions::Exponential]
      #     The exponential buckets.
      # @!attribute [rw] explicit_buckets
      #   @return [Google::Api::Distribution::BucketOptions::Explicit]
      #     The explicit buckets.
      class BucketOptions
        # Specifies a linear sequence of buckets that all have the same width
        # (except overflow and underflow). Each bucket represents a constant
        # absolute uncertainty on the specific value in the bucket.
        #
        # There are `num_finite_buckets + 2` (= N) buckets. Bucket `i` has the
        # following boundaries:
        #
        #    Upper bound (0 <= i < N-1):     offset + (width * i).
        #    Lower bound (1 <= i < N):       offset + (width * (i - 1)).
        # @!attribute [rw] num_finite_buckets
        #   @return [Integer]
        #     Must be greater than 0.
        # @!attribute [rw] width
        #   @return [Float]
        #     Must be greater than 0.
        # @!attribute [rw] offset
        #   @return [Float]
        #     Lower bound of the first bucket.
        class Linear; end

        # Specifies an exponential sequence of buckets that have a width that is
        # proportional to the value of the lower bound. Each bucket represents a
        # constant relative uncertainty on a specific value in the bucket.
        #
        # There are `num_finite_buckets + 2` (= N) buckets. Bucket `i` has the
        # following boundaries:
        #
        #    Upper bound (0 <= i < N-1):     scale * (growth_factor ^ i).
        #    Lower bound (1 <= i < N):       scale * (growth_factor ^ (i - 1)).
        # @!attribute [rw] num_finite_buckets
        #   @return [Integer]
        #     Must be greater than 0.
        # @!attribute [rw] growth_factor
        #   @return [Float]
        #     Must be greater than 1.
        # @!attribute [rw] scale
        #   @return [Float]
        #     Must be greater than 0.
        class Exponential; end

        # Specifies a set of buckets with arbitrary widths.
        #
        # There are `size(bounds) + 1` (= N) buckets. Bucket `i` has the following
        # boundaries:
        #
        #    Upper bound (0 <= i < N-1):     bounds[i]
        #    Lower bound (1 <= i < N);       bounds[i - 1]
        #
        # The `bounds` field must contain at least one element. If `bounds` has
        # only one element, then there are no finite buckets, and that single
        # element is the common boundary of the overflow and underflow buckets.
        # @!attribute [rw] bounds
        #   @return [Array<Float>]
        #     The values must be monotonically increasing.
        class Explicit; end
      end

      # Exemplars are example points that may be used to annotate aggregated
      # distribution values. They are metadata that gives information about a
      # particular value added to a Distribution bucket, such as a trace ID that
      # was active when a value was added. They may contain further information,
      # such as a example values and timestamps, origin, etc.
      # @!attribute [rw] value
      #   @return [Float]
      #     Value of the exemplar point. This value determines to which bucket the
      #     exemplar belongs.
      # @!attribute [rw] timestamp
      #   @return [Google::Protobuf::Timestamp]
      #     The observation (sampling) time of the above value.
      # @!attribute [rw] attachments
      #   @return [Array<Google::Protobuf::Any>]
      #     Contextual information about the example value. Examples are:
      #
      #       Trace: type.googleapis.com/google.monitoring.v3.SpanContext
      #
      #       Literal string: type.googleapis.com/google.protobuf.StringValue
      #
      #       Labels dropped during aggregation:
      #         type.googleapis.com/google.monitoring.v3.DroppedLabels
      #
      #     There may be only a single attachment of any given message type in a
      #     single exemplar, and this is enforced by the system.
      class Exemplar; end
    end
  end
end