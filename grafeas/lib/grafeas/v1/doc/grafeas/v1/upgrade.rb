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


module Grafeas
  module V1
    # An Upgrade Note represents a potential upgrade of a package to a given
    # version. For each package version combination (i.e. bash 4.0, bash 4.1,
    # bash 4.1.2), there will be an Upgrade Note. For Windows, windows_update field
    # represents the information related to the update.
    # @!attribute [rw] package
    #   @return [String]
    #     Required for non-Windows OS. The package this Upgrade is for.
    # @!attribute [rw] version
    #   @return [Grafeas::V1::Version]
    #     Required for non-Windows OS. The version of the package in machine + human
    #     readable form.
    # @!attribute [rw] distributions
    #   @return [Array<Grafeas::V1::UpgradeDistribution>]
    #     Metadata about the upgrade for each specific operating system.
    # @!attribute [rw] windows_update
    #   @return [Grafeas::V1::WindowsUpdate]
    #     Required for Windows OS. Represents the metadata about the Windows update.
    class UpgradeNote; end

    # The Upgrade Distribution represents metadata about the Upgrade for each
    # operating system (CPE). Some distributions have additional metadata around
    # updates, classifying them into various categories and severities.
    # @!attribute [rw] cpe_uri
    #   @return [String]
    #     Required - The specific operating system this metadata applies to. See
    #     https://cpe.mitre.org/specification/.
    # @!attribute [rw] classification
    #   @return [String]
    #     The operating system classification of this Upgrade, as specified by the
    #     upstream operating system upgrade feed. For Windows the classification is
    #     one of the category_ids listed at
    #     https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ff357803(v=vs.85)
    # @!attribute [rw] severity
    #   @return [String]
    #     The severity as specified by the upstream operating system.
    # @!attribute [rw] cve
    #   @return [Array<String>]
    #     The cve tied to this Upgrade.
    class UpgradeDistribution; end

    # Windows Update represents the metadata about the update for the Windows
    # operating system. The fields in this message come from the Windows Update API
    # documented at
    # https://docs.microsoft.com/en-us/windows/win32/api/wuapi/nn-wuapi-iupdate.
    # @!attribute [rw] identity
    #   @return [Grafeas::V1::WindowsUpdate::Identity]
    #     Required - The unique identifier for the update.
    # @!attribute [rw] title
    #   @return [String]
    #     The localized title of the update.
    # @!attribute [rw] description
    #   @return [String]
    #     The localized description of the update.
    # @!attribute [rw] categories
    #   @return [Array<Grafeas::V1::WindowsUpdate::Category>]
    #     The list of categories to which the update belongs.
    # @!attribute [rw] kb_article_ids
    #   @return [Array<String>]
    #     The Microsoft Knowledge Base article IDs that are associated with the
    #     update.
    # @!attribute [rw] support_url
    #   @return [String]
    #     The hyperlink to the support information for the update.
    # @!attribute [rw] last_published_timestamp
    #   @return [Google::Protobuf::Timestamp]
    #     The last published timestamp of the update.
    class WindowsUpdate
      # The unique identifier of the update.
      # @!attribute [rw] update_id
      #   @return [String]
      #     The revision independent identifier of the update.
      # @!attribute [rw] revision
      #   @return [Integer]
      #     The revision number of the update.
      class Identity; end

      # The category to which the update belongs.
      # @!attribute [rw] category_id
      #   @return [String]
      #     The identifier of the category.
      # @!attribute [rw] name
      #   @return [String]
      #     The localized name of the category.
      class Category; end
    end

    # An Upgrade Occurrence represents that a specific resource_url could install a
    # specific upgrade. This presence is supplied via local sources (i.e. it is
    # present in the mirror and the running system has noticed its availability).
    # For Windows, both distribution and windows_update contain information for the
    # Windows update.
    # @!attribute [rw] package
    #   @return [String]
    #     Required for non-Windows OS. The package this Upgrade is for.
    # @!attribute [rw] parsed_version
    #   @return [Grafeas::V1::Version]
    #     Required for non-Windows OS. The version of the package in a machine +
    #     human readable form.
    # @!attribute [rw] distribution
    #   @return [Grafeas::V1::UpgradeDistribution]
    #     Metadata about the upgrade for available for the specific operating system
    #     for the resource_url. This allows efficient filtering, as well as
    #     making it easier to use the occurrence.
    # @!attribute [rw] windows_update
    #   @return [Grafeas::V1::WindowsUpdate]
    #     Required for Windows OS. Represents the metadata about the Windows update.
    class UpgradeOccurrence; end
  end
end