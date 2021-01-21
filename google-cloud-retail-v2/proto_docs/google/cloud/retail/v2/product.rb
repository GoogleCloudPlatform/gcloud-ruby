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


module Google
  module Cloud
    module Retail
      module V2
        # Product captures all metadata information of items to be recommended or
        # searched.
        # @!attribute [rw] name
        #   @return [::String]
        #     Immutable. Full resource name of the product, such as
        #     `projects/*/locations/global/catalogs/default_catalog/branches/default_branch/products/product_id`.
        #
        #     The branch ID must be "default_branch".
        # @!attribute [rw] id
        #   @return [::String]
        #     Immutable. {::Google::Cloud::Retail::V2::Product Product} identifier, which is
        #     the final component of {::Google::Cloud::Retail::V2::Product#name name}. For
        #     example, this field is "id_1", if
        #     {::Google::Cloud::Retail::V2::Product#name name} is
        #     `projects/*/locations/global/catalogs/default_catalog/branches/default_branch/products/id_1`.
        #
        #     This field must be a UTF-8 encoded string with a length limit of 128
        #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
        #
        #     Google Merchant Center property
        #     [id](https://support.google.com/merchants/answer/6324405). Schema.org
        #     Property [Product.sku](https://schema.org/sku).
        # @!attribute [rw] type
        #   @return [::Google::Cloud::Retail::V2::Product::Type]
        #     Immutable. The type of the product. This field is output-only.
        # @!attribute [rw] primary_product_id
        #   @return [::String]
        #     Variant group identifier. Must be an
        #     {::Google::Cloud::Retail::V2::Product#id id}, with the same parent branch with
        #     this product. Otherwise, an error is thrown.
        #
        #     For {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY}
        #     {::Google::Cloud::Retail::V2::Product Product}s, this field can only be empty or
        #     set to the same value as {::Google::Cloud::Retail::V2::Product#id id}.
        #
        #     For VARIANT {::Google::Cloud::Retail::V2::Product Product}s, this field cannot
        #     be empty. A maximum of 2,000 products are allowed to share the same
        #     {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY}
        #     {::Google::Cloud::Retail::V2::Product Product}. Otherwise, an INVALID_ARGUMENT
        #     error is returned.
        #
        #     Google Merchant Center Property
        #     [item_group_id](https://support.google.com/merchants/answer/6324507).
        #     Schema.org Property
        #     [Product.inProductGroupWithID](https://schema.org/inProductGroupWithID).
        #
        #     This field must be enabled before it can be used. [Learn
        #     more](/recommendations-ai/docs/catalog#item-group-id).
        # @!attribute [rw] categories
        #   @return [::Array<::String>]
        #     Product categories. This field is repeated for supporting one product
        #     belonging to several parallel categories. Strongly recommended using the
        #     full path for better search / recommendation quality.
        #
        #
        #     To represent full path of category, use '>' sign to separate different
        #     hierarchies. If '>' is part of the category name, please replace it with
        #     other character(s).
        #
        #     For example, if a shoes product belongs to both
        #     ["Shoes & Accessories" -> "Shoes"] and
        #     ["Sports & Fitness" -> "Athletic Clothing" -> "Shoes"], it could be
        #     represented as:
        #
        #          "categories": [
        #            "Shoes & Accessories > Shoes",
        #            "Sports & Fitness > Athletic Clothing > Shoes"
        #          ]
        #
        #     Must be set for {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY}
        #     {::Google::Cloud::Retail::V2::Product Product} otherwise an INVALID_ARGUMENT
        #     error is returned.
        #
        #     At most 250 values are allowed per
        #     {::Google::Cloud::Retail::V2::Product Product}. Empty values are not allowed.
        #     Each value must be a UTF-8 encoded string with a length limit of 5,000
        #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
        #
        #     Google Merchant Center property
        #     [google_product_category][mc_google_product_category]. Schema.org property
        #     [Product.category] (https://schema.org/category).
        #
        #     [mc_google_product_category]:
        #     https://support.google.com/merchants/answer/6324436
        # @!attribute [rw] title
        #   @return [::String]
        #     Required. Product title.
        #
        #     This field must be a UTF-8 encoded string with a length limit of 128
        #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
        #
        #     Google Merchant Center property
        #     [title](https://support.google.com/merchants/answer/6324415). Schema.org
        #     property [Product.name](https://schema.org/name).
        # @!attribute [rw] description
        #   @return [::String]
        #     Product description.
        #
        #     This field must be a UTF-8 encoded string with a length limit of 5,000
        #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
        #
        #     Google Merchant Center property
        #     [description](https://support.google.com/merchants/answer/6324468).
        #     schema.org property [Product.description](https://schema.org/description).
        # @!attribute [rw] attributes
        #   @return [::Google::Protobuf::Map{::String => ::Google::Cloud::Retail::V2::CustomAttribute}]
        #     Highly encouraged. Extra product attributes to be included. For example,
        #     for products, this could include the store name, vendor, style, color, etc.
        #     These are very strong signals for recommendation model, thus we highly
        #     recommend providing the attributes here.
        #
        #     Features that can take on one of a limited number of possible values. Two
        #     types of features can be set are:
        #
        #     Textual features. some examples would be the brand/maker of a product, or
        #     country of a customer. Numerical features. Some examples would be the
        #     height/weight of a product, or age of a customer.
        #
        #     For example: `{ "vendor": {"text": ["vendor123", "vendor456"]},
        #     "lengths_cm": \\{"numbers":[2.3, 15.4]}, "heights_cm": \\{"numbers":[8.1, 6.4]}
        #     }`.
        #
        #     A maximum of 150 attributes are allowed. Otherwise, an INVALID_ARGUMENT
        #     error is returned.
        #
        #     The key must be a UTF-8 encoded string with a length limit of 5,000
        #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
        # @!attribute [rw] tags
        #   @return [::Array<::String>]
        #     Custom tags associated with the product.
        #
        #     At most 250 values are allowed per
        #     {::Google::Cloud::Retail::V2::Product Product}. This value must be a UTF-8
        #     encoded string with a length limit of 1,000 characters. Otherwise, an
        #     INVALID_ARGUMENT error is returned.
        #
        #     This tag can be used for filtering recommendation results by passing the
        #     tag as part of the
        #     {::Google::Cloud::Retail::V2::PredictRequest#filter PredictRequest.filter}.
        #
        #     Google Merchant Center property
        #     [custom_label_0–4](https://support.google.com/merchants/answer/6324473).
        # @!attribute [rw] price_info
        #   @return [::Google::Cloud::Retail::V2::PriceInfo]
        #     Product price and cost information.
        #
        #     Google Merchant Center property
        #     [price](https://support.google.com/merchants/answer/6324371).
        # @!attribute [rw] available_time
        #   @return [::Google::Protobuf::Timestamp]
        #     The timestamp when this {::Google::Cloud::Retail::V2::Product Product} becomes
        #     available recommendation and search.
        # @!attribute [rw] availability
        #   @return [::Google::Cloud::Retail::V2::Product::Availability]
        #     The online availability of the {::Google::Cloud::Retail::V2::Product Product}.
        #     Default to
        #     {::Google::Cloud::Retail::V2::Product::Availability::IN_STOCK Availability.IN_STOCK}.
        #
        #     Google Merchant Center Property
        #     [availability](https://support.google.com/merchants/answer/6324448).
        #     Schema.org Property [Offer.availability](https://schema.org/availability).
        # @!attribute [rw] available_quantity
        #   @return [::Google::Protobuf::Int32Value]
        #     The available quantity of the item.
        # @!attribute [rw] uri
        #   @return [::String]
        #     Canonical URL directly linking to the product detail page.
        #
        #     This field must be a UTF-8 encoded string with a length limit of 5,000
        #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
        #
        #     Google Merchant Center property
        #     [link](https://support.google.com/merchants/answer/6324416). Schema.org
        #     property [Offer.url](https://schema.org/url).
        # @!attribute [rw] images
        #   @return [::Array<::Google::Cloud::Retail::V2::Image>]
        #     Product images for the product.
        #
        #     A maximum of 300 images are allowed.
        #
        #     Google Merchant Center property
        #     [image_link](https://support.google.com/merchants/answer/6324350).
        #     Schema.org property [Product.image](https://schema.org/image).
        class Product
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [::String]
          # @!attribute [rw] value
          #   @return [::Google::Cloud::Retail::V2::CustomAttribute]
          class AttributesEntry
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # The type of this product.
          module Type
            # Default value. Default to
            # {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY} if unset.
            TYPE_UNSPECIFIED = 0

            # The primary type.
            #
            # As the primary unit for predicting, indexing and search serving, a
            # {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY}
            # {::Google::Cloud::Retail::V2::Product Product} is grouped with multiple
            # {::Google::Cloud::Retail::V2::Product::Type::VARIANT Type.VARIANT}
            # {::Google::Cloud::Retail::V2::Product Product}s.
            PRIMARY = 1

            # The variant type.
            #
            # {::Google::Cloud::Retail::V2::Product::Type::VARIANT Type.VARIANT}
            # {::Google::Cloud::Retail::V2::Product Product}s usually share some common
            # attributes on the same
            # {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY}
            # {::Google::Cloud::Retail::V2::Product Product}s, but they have variant
            # attributes like different colors, sizes and prices, etc.
            VARIANT = 2

            # The collection type. Collection products are bundled
            # {::Google::Cloud::Retail::V2::Product::Type::PRIMARY Type.PRIMARY}
            # {::Google::Cloud::Retail::V2::Product Product}s or
            # {::Google::Cloud::Retail::V2::Product::Type::VARIANT Type.VARIANT}
            # {::Google::Cloud::Retail::V2::Product Product}s that are sold together, such
            # as a jewelry set with necklaces, earrings and rings, etc.
            COLLECTION = 3
          end

          # Product availability. If this field is unspecified, the product is
          # assumed to be in stock.
          module Availability
            # Default product availability. Default to
            # {::Google::Cloud::Retail::V2::Product::Availability::IN_STOCK Availability.IN_STOCK}
            # if unset.
            AVAILABILITY_UNSPECIFIED = 0

            # Product in stock.
            IN_STOCK = 1

            # Product out of stock.
            OUT_OF_STOCK = 2

            # Product that is in pre-order state.
            PREORDER = 3

            # Product that is back-ordered (i.e. temporarily out of stock).
            BACKORDER = 4
          end
        end
      end
    end
  end
end
