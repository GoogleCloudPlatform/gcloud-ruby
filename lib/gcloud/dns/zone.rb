#--
# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "gcloud/dns/change"
require "gcloud/dns/zone/transaction"
require "gcloud/dns/zone/list"
require "gcloud/dns/record"
require "gcloud/dns/importer"
require "time"

module Gcloud
  module Dns
    ##
    # = DNS Zone
    #
    # The managed zone is the container for DNS records for the same DNS name
    # suffix and has a set of name servers that accept and responds to queries.
    # A project can have multiple managed zones, but they must each have a
    # unique name.
    #
    #   require "gcloud"
    #
    #   gcloud = Gcloud.new
    #   dns = gcloud.dns
    #   zone = dns.zone "example-com"
    #   zone.records.each do |record|
    #     puts record.name
    #   end
    #
    # For more information, see {Managing
    # Zones}[https://cloud.google.com/dns/zones/].
    #
    class Zone
      ##
      # The Connection object.
      attr_accessor :connection #:nodoc:

      ##
      # The Google API Client object.
      attr_accessor :gapi #:nodoc:

      ##
      # Create an empty Zone object.
      def initialize #:nodoc:
        @connection = nil
        @gapi = {}
      end

      ##
      # Unique identifier for the resource; defined by the server.
      #
      def id
        @gapi["id"]
      end

      ##
      # User assigned name for this resource. Must be unique within the project.
      # The name must be 1-32 characters long, must begin with a letter, end
      # with a letter or digit, and only contain lowercase letters, digits or
      # dashes.
      #
      def name
        @gapi["name"]
      end

      ##
      # The DNS name of this managed zone, for instance "example.com.".
      #
      def dns
        @gapi["dnsName"]
      end

      ##
      # A string of at most 1024 characters associated with this resource for
      # the user's convenience. Has no effect on the managed zone's function.
      #
      def description
        @gapi["description"]
      end

      ##
      # Delegate your managed_zone to these virtual name servers; defined by the
      # server.
      #
      def name_servers
        Array(@gapi["nameServers"])
      end

      ##
      # Optionally specifies the NameServerSet for this ManagedZone. A
      # NameServerSet is a set of DNS name servers that all host the same
      # ManagedZones. Most users will leave this field unset.
      #
      def name_server_set
        @gapi["nameServerSet"]
      end

      ##
      # The time that this resource was created on the server.
      #
      def created_at
        Time.parse @gapi["creationTime"]
      rescue
        nil
      end

      ##
      # Permanently deletes the zone.
      #
      # === Parameters
      #
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:force]</code>::
      #   If +true+, ensures the deletion of the zone by first deleting all
      #   records. If +false+ and the zone contains non-essential records, the
      #   request will fail. Default is +false+. (+Boolean+)
      #
      # === Returns
      #
      # +true+ if the zone was deleted.
      #
      # === Examples
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   zone.delete
      #
      # The zone can be forcefully deleted with the +force+ option:
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   zone.delete force: true
      #
      def delete options = {}
        clear! if options[:force]

        ensure_connection!
        resp = connection.delete_zone id
        if resp.success?
          true
        else
          fail ApiError.from_response(resp)
        end
      end

      ##
      # Removes non-essential records from the zone. Only NS and SOA records
      # will be kept.
      #
      # === Examples
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   zone.clear!
      #
      def clear!
        non_essential = records.all.reject { |r| %w(SOA NS).include?(r.type) }
        change = update [], non_essential
        change.wait_until_done! unless change.nil?
      end

      ##
      # Retrieves an existing change by id.
      #
      # === Parameters
      #
      # +change_id+::
      #   The id of a change. (+String+)
      #
      # === Returns
      #
      # Gcloud::Dns::Change or +nil+ if the change does not exist
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.change "2"
      #   if change
      #     puts "#{change.id} - #{change.started_at} - #{change.status}"
      #   end
      #
      def change change_id
        ensure_connection!
        resp = connection.get_change id, change_id
        if resp.success?
          Change.from_gapi resp.data, self
        else
          nil
        end
      end
      alias_method :find_change, :change
      alias_method :get_change, :change

      ##
      # Retrieves the list of changes belonging to the zone.
      #
      # === Parameters
      #
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:token]</code>::
      #   A previously-returned page token representing part of the larger set
      #   of results to view. (+String+)
      # <code>options[:max]</code>::
      #   Maximum number of changes to return. (+Integer+)
      # <code>options[:order]</code>::
      #   Sort the changes by change sequence. (+Symbol+ or +String+)
      #
      #   Acceptable values are:
      #   * +asc+ - Sort by ascending change sequence
      #   * +desc+ - Sort by descending change sequence
      #
      # === Returns
      #
      # Array of Gcloud::Dns::Change (See Gcloud::Dns::Change::List)
      #
      # === Examples
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   changes = zone.changes
      #   changes.each do |change|
      #     puts "#{change.id} - #{change.started_at} - #{change.status}"
      #   end
      #
      # The changes can be sorted by change sequence:
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   changes = zone.changes order: :desc
      #
      # If you have a significant number of changes, you may need to paginate
      # through them: (See Gcloud::Dns::Change::List)
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   changes = zone.changes
      #   loop do
      #     changes.each do |change|
      #       puts "#{change.name} - #{change.status}"
      #     end
      #     break unless changes.next?
      #     changes = changes.next
      #   end
      #
      def changes options = {}
        ensure_connection!
        # Fix the sort options
        options[:order] = adjust_change_sort_order options[:order]
        options[:sort]  = "changeSequence" if options[:order]
        # Continue with the API call
        resp = connection.list_changes id, options
        if resp.success?
          Change::List.from_response resp, self
        else
          fail ApiError.from_response(resp)
        end
      end
      alias_method :find_changes, :changes

      ##
      # Retrieves the list of records belonging to the zone.
      #
      # === Parameters
      #
      # +name+::
      #   Return only records with this domain or subdomain name. (+String+)
      # +type+::
      #   Return only records with this {record
      #   type}[https://cloud.google.com/dns/what-is-cloud-dns].
      #   If present, the +name+ parameter must also be present. (+String+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:token]</code>::
      #   A previously-returned page token representing part of the larger set
      #   of results to view. (+String+)
      # <code>options[:max]</code>::
      #   Maximum number of records to return. (+Integer+)
      #
      # === Returns
      #
      # Array of Gcloud::Dns::Record (See Gcloud::Dns::Record::List)
      #
      # === Examples
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   records = zone.records
      #   records.each do |record|
      #     puts record.name
      #   end
      #
      # Records can be filtered by name and type. The name argument can be a
      # subdomain (e.g., +www+) fragment for convenience, but notice that the
      # retrieved record's domain name is always fully-qualified.
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   records = zone.records "www", "A"
      #   records.first.name #=> "www.example.com."
      #
      # If you have a significant number of records, you may need to paginate
      # through them: (See Gcloud::Dns::Record::List)
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   records = zone.records "example.com."
      #   loop do
      #     records.each do |record|
      #       puts record.name
      #     end
      #     break unless records.next?
      #     records = records.next
      #   end
      #
      # Or, instead of paging manually, you can retrieve all of the pages in a
      # single call: (See Gcloud::Dns::Record::List#all)
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   records = zone.records.all
      #
      def records name = nil, type = nil, options = {}
        ensure_connection!

        options = build_records_options name, type, options

        resp = connection.list_records id, options
        if resp.success?
          Record::List.from_response resp, self
        else
          fail ApiError.from_response(resp)
        end
      end
      alias_method :find_records, :records

      ##
      # Creates a new, unsaved Record that can be added to a Zone.
      #
      # === Returns
      #
      # Gcloud::Dns::Record
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   record = zone.record "example.com.", "A", 86400, ["1.2.3.4"]
      #   zone.add record
      #
      def record name, type, ttl, data
        Gcloud::Dns::Record.new fqdn(name), type, ttl, data
      end
      alias_method :new_record, :record

      ##
      # Exports the zone to a local {DNS zone
      # file}[https://en.wikipedia.org/wiki/Zone_file].
      #
      # === Parameters
      #
      # +path+::
      #   The path on the local file system to write the data to.
      #   The path provided must be writable. (+String+)
      #
      # === Returns
      #
      # +::File+ object on the local file system
      #
      # === Examples
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #
      #   zone.export "path/to/db.example.com"
      #
      def export path
        File.open path, "w" do |f|
          f.write to_zonefile
        end
      end

      ##
      # Imports resource records from a {DNS zone
      # file}[https://en.wikipedia.org/wiki/Zone_file], adding the new records
      # to the zone, without removing any existing records from the zone.
      #
      # Because the Google Cloud DNS API only accepts a single resource record
      # for each +name+ and +type+ combination (with multiple +data+ elements),
      # the zone file's records are merged as necessary. During this merge, the
      # lowest +ttl+ of the merged records is used. If none of the merged
      # records have a +ttl+ value, the zone file's global TTL is used for the
      # record.
      #
      # The zone file's SOA and NS records are not imported, because the zone
      # was given SOA and NS records when it was created. These generated
      # records point to Cloud DNS name servers.
      #
      # This operation automatically updates the SOA record serial number unless
      # prevented with the +skip_soa+ option. See #update for details.
      #
      # The Google Cloud DNS service requires that record names and data use
      # fully-qualified addresses. The @ symbol is not accepted, nor are
      # unqualified subdomain addresses like www. If your zone file contains
      # such values, you may need to pre-process it in order for the import
      # operation to succeed.
      #
      # === Parameters
      #
      # +path_or_io+::
      #   The path to a zone file on the filesystem, or an IO instance from
      #   which zone file data can be read. (+String+ or +IO+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:only]</code>::
      #   Include only records of this type or types. (+String+ or +Array+)
      # <code>options[:except]</code>::
      #   Exclude records of this type or types. (+String+ or +Array+)
      # <code>options[:skip_soa]</code>::
      #   Do not automatically update the SOA record serial number. See #update
      #   for details. (+Boolean+)
      # <code>options[:soa_serial]</code>::
      #   A value (or a lambda or Proc returning a value) for the new SOA record
      #   serial number. See #update for details. (+Integer+, lambda, or +Proc+)
      #
      # === Returns
      #
      # A new Change adding the imported Record instances.
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.import "path/to/db.example.com"
      #
      def import path_or_io, options = {}
        options[:except] = Array(options[:except]).map(&:to_s).map(&:upcase)
        options[:except] = (options[:except] + %w(SOA NS)).uniq
        additions = Gcloud::Dns::Importer.new(self, path_or_io).records(options)
        update additions, []
      end

      # rubocop:disable all
      # Disabled rubocop because this complexity cannot easily be avoided.

      ##
      # Adds and removes Records from the zone. All changes are made in a single
      # API request.
      #
      # If the SOA record for the zone is not present in +additions+ or
      # +deletions+ (and if present in one, it should be present in the other),
      # it will be added to both, and its serial number will be incremented by
      # adding +1+. This update to the SOA record can be prevented with the
      # +skip_soa+ option. To provide your own value or behavior for the new
      # serial number, use the +soa_serial+ option.
      #
      # === Parameters
      #
      # +additions+::
      #   The Record or array of records to add. (Record or +Array+)
      # +deletions+::
      #   The Record or array of records to remove. (Record or +Array+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:skip_soa]</code>::
      #   Do not automatically update the SOA record serial number. (+Boolean+)
      # <code>options[:soa_serial]</code>::
      #   A value (or a lambda or Proc returning a value) for the new SOA record
      #   serial number. (+Integer+, lambda, or +Proc+)
      #
      # === Returns
      #
      # Gcloud::Dns::Change
      #
      # === Examples
      #
      # The best way to add, remove, and update multiple records in a single
      # {transaction}[https://cloud.google.com/dns/records] is with a block. See
      # Zone::Transaction.
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.update do |tx|
      #     tx.add     "example.com.", "A",  86400, "1.2.3.4"
      #     tx.remove  "example.com.", "TXT"
      #     tx.replace "example.com.", "MX", 86400, ["10 mail1.example.com.",
      #                                              "20 mail2.example.com."]
      #     tx.modify "www.example.com.", "CNAME" do |cname|
      #       cname.ttl = 86400 # only change the TTL
      #     end
      #   end
      #
      # Or you can provide the record objects to add and remove.
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   new_record = zone.record "example.com.", "A", 86400, ["1.2.3.4"]
      #   old_record = zone.record "example.com.", "A", 18600, ["1.2.3.4"]
      #   change = zone.update [new_record], [old_record]
      #
      # You can provide a lambda or Proc that receives the current SOA record
      # serial number and returns a new serial number.
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   new_record = zone.record "example.com.", "A", 86400, ["1.2.3.4"]
      #   change = zone.update new_record, soa_serial: lambda { |sn| sn + 10 }
      #
      def update additions = [], deletions = [], options = {}
        # Handle only sending in options
        if additions.is_a?(::Hash) && deletions.empty? && options.empty?
          options = additions
          additions = []
        elsif deletions.is_a?(::Hash) && options.empty?
          options = deletions
          deletions = []
        end

        additions = Array additions
        deletions = Array deletions

        if block_given?
          updater = Zone::Transaction.new self
          yield updater
          additions += updater.additions
          deletions += updater.deletions
        end

        to_add    = additions - deletions
        to_remove = deletions - additions
        return nil if to_add.empty? && to_remove.empty?
        unless options[:skip_soa] || detect_soa(to_add) || detect_soa(to_remove)
          increment_soa to_add, to_remove, options[:soa_serial]
        end
        create_change to_add, to_remove
      end

      # rubocop:enable all

      ##
      # Adds a record to the Zone. In order to update existing records, or add
      # and delete records in the same transaction, use #update.
      #
      # This operation automatically updates the SOA record serial number unless
      # prevented with the +skip_soa+ option. See #update for details.
      #
      # === Parameters
      #
      # +name+::
      #   The owner of the record. For example: +example.com.+. (+String+)
      # +type+::
      #   The identifier of a {supported record
      #   type}[https://cloud.google.com/dns/what-is-cloud-dns].
      #   For example: +A+, +AAAA+, +CNAME+, +MX+, or +TXT+. (+String+)
      # +ttl+::
      #   The number of seconds that the record can be cached by resolvers.
      #   (+Integer+)
      # +data+::
      #   The resource record data, as determined by +type+ and defined in {RFC
      #   1035 (section 5)}[http://tools.ietf.org/html/rfc1035#section-5] and
      #   {RFC 1034
      #   (section 3.6.1)}[http://tools.ietf.org/html/rfc1034#section-3.6.1].
      #   For example: +192.0.2.1+ or +example.com.+. (+String+ or +Array+ of
      #   +String+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:skip_soa]</code>::
      #   Do not automatically update the SOA record serial number. See #update
      #   for details. (+Boolean+)
      # <code>options[:soa_serial]</code>::
      #   A value (or a lambda or Proc returning a value) for the new SOA record
      #   serial number. See #update for details. (+Integer+, lambda, or +Proc+)
      #
      # === Returns
      #
      # Gcloud::Dns::Change
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.add "example.com.", "A", 86400, ["1.2.3.4"]
      #
      def add name, type, ttl, data, options = {}
        update [record(name, type, ttl, data)], [], options
      end

      ##
      # Removes records from the Zone. The records are looked up before they are
      # removed. In order to update existing records, or add and remove records
      # in the same transaction, use #update.
      #
      # This operation automatically updates the SOA record serial number unless
      # prevented with the +skip_soa+ option. See #update for details.
      #
      # === Parameters
      #
      # +name+::
      #   The owner of the record. For example: +example.com.+. (+String+)
      # +type+::
      #   The identifier of a {supported record
      #   type}[https://cloud.google.com/dns/what-is-cloud-dns].
      #   For example: +A+, +AAAA+, +CNAME+, +MX+, or +TXT+. (+String+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:skip_soa]</code>::
      #   Do not automatically update the SOA record serial number. See #update
      #   for details. (+Boolean+)
      # <code>options[:soa_serial]</code>::
      #   A value (or a lambda or Proc returning a value) for the new SOA record
      #   serial number. See #update for details. (+Integer+, lambda, or +Proc+)
      #
      # === Returns
      #
      # Gcloud::Dns::Change
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.remove "example.com.", "A"
      #
      def remove name, type, options = {}
        update [], records(name: name, type: type).all.to_a, options
      end

      ##
      # Replaces existing records on the Zone. Records matching the +name+ and
      # +type+ are replaced. In order to update existing records, or add and
      # delete records in the same transaction, use #update.
      #
      # This operation automatically updates the SOA record serial number unless
      # prevented with the +skip_soa+ option. See #update for details.
      #
      # === Parameters
      #
      # +name+::
      #   The owner of the record. For example: +example.com.+. (+String+)
      # +type+::
      #   The identifier of a {supported record
      #   type}[https://cloud.google.com/dns/what-is-cloud-dns].
      #   For example: +A+, +AAAA+, +CNAME+, +MX+, or +TXT+. (+String+)
      # +ttl+::
      #   The number of seconds that the record can be cached by resolvers.
      #   (+Integer+)
      # +data+::
      #   The resource record data, as determined by +type+ and defined in
      #   {RFC 1035 (section 5)}[http://tools.ietf.org/html/rfc1035#section-5]
      #   and {RFC 1034 (section
      #   3.6.1)}[http://tools.ietf.org/html/rfc1034#section-3.6.1]. For
      #   example: +192.0.2.1+ or +example.com.+. (+String+ or +Array+ of
      #   +String+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:skip_soa]</code>::
      #   Do not automatically update the SOA record serial number. See #update
      #   for details. (+Boolean+)
      # <code>options[:soa_serial]</code>::
      #   A value (or a lambda or Proc returning a value) for the new SOA record
      #   serial number. See #update for details. (+Integer+, lambda, or +Proc+)
      #
      # === Returns
      #
      # Gcloud::Dns::Change
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.replace "example.com.", "A", 86400, ["5.6.7.8"]
      #
      def replace name, type, ttl, data, options = {}
        update [record(name, type, ttl, data)],
               records(name: name, type: type).all.to_a,
               options
      end

      def to_zonefile #:nodoc:
        records.all.map(&:to_zonefile_records).flatten.join("\n")
      end

      ##
      # Modifies records on the Zone. Records matching the +name+ and +type+ are
      # yielded to the block where they can be modified.
      #
      # This operation automatically updates the SOA record serial number unless
      # prevented with the +skip_soa+ option. See #update for details.
      #
      # === Parameters
      #
      # +name+::
      #   The owner of the record. For example: +example.com.+. (+String+)
      # +type+::
      #   The identifier of a {supported record
      #   type}[https://cloud.google.com/dns/what-is-cloud-dns].
      #   For example: +A+, +AAAA+, +CNAME+, +MX+, or +TXT+. (+String+)
      # +options+::
      #   An optional Hash for controlling additional behavior. (+Hash+)
      # <code>options[:skip_soa]</code>::
      #   Do not automatically update the SOA record serial number. See #update
      #   for details. (+Boolean+)
      # <code>options[:soa_serial]</code>::
      #   A value (or a lambda or Proc returning a value) for the new SOA record
      #   serial number. See #update for details. (+Integer+, lambda, or +Proc+)
      #
      # === Returns
      #
      # Gcloud::Dns::Change
      #
      # === Example
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   change = zone.modify "example.com.", "MX" do |mx|
      #     mx.ttl = 3600 # change only the TTL
      #   end
      #
      def modify name, type, options = {}
        existing = records(name: name, type: type).all.to_a
        updated = existing.map(&:dup)
        updated.each { |r| yield r }
        update updated, existing, options
      end

      ##
      # This helper converts the given domain name or subdomain (e.g., +www+)
      # fragment to a {fully qualified domain name
      # (FQDN)}[https://en.wikipedia.org/wiki/Fully_qualified_domain_name] for
      # the zone's #dns. If the argument is already a FQDN, it is returned
      # unchanged.
      #
      # === Parameters
      #
      # +domain_name+::
      #   The name to convert to a fully qualified domain name. (+String+)
      #
      # === Returns
      #
      # A fully qualified domain name. (+String+)
      #
      # === Examples
      #
      #   require "gcloud"
      #
      #   gcloud = Gcloud.new
      #   dns = gcloud.dns
      #   zone = dns.zone "example-com"
      #   zone.fqdn "www" #=> "www.example.com."
      #   zone.fqdn "@" #=> "example.com."
      #   zone.fqdn "mail.example.com." #=> "mail.example.com."
      #
      def fqdn domain_name
        Connection.fqdn domain_name, dns
      end

      ##
      # New Zone from a Google API Client object.
      def self.from_gapi gapi, conn #:nodoc:
        new.tap do |f|
          f.gapi = gapi
          f.connection = conn
        end
      end

      protected

      ##
      # Raise an error unless an active connection is available.
      def ensure_connection!
        fail "Must have active connection" unless connection
      end

      # rubocop:disable all
      # Disabled rubocop because this complexity cannot easily be avoided.

      def build_records_options name, type, options
        # Handle only sending in options
        if name.is_a?(::Hash) && type.nil? && options.empty?
          options = name
          name = nil
        elsif type.is_a?(::Hash) && options.empty?
          options = type
          type = nil
        end

        # Set parameters as options, params have priority
        options[:name] = name || options[:name]
        options[:type] = type || options[:type]

        # Ensure name is a FQDN
        options[:name] = fqdn(options[:name]) if options[:name]

        # return only the options
        options
      end

      # rubocop:enable all

      def create_change additions, deletions
        ensure_connection!
        resp = connection.create_change id,
                                        additions.map(&:to_gapi),
                                        deletions.map(&:to_gapi)
        if resp.success?
          Change.from_gapi resp.data, self
        else
          fail ApiError.from_response(resp)
        end
      end

      def increment_soa to_add, to_remove, soa_serial
        current_soa = detect_soa records(name: dns, type: "SOA").all
        return false if current_soa.nil?
        updated_soa = current_soa.dup
        updated_soa.data[0] = replace_soa_serial updated_soa.data[0], soa_serial
        to_add << updated_soa
        to_remove << current_soa
      end

      def detect_soa records
        records.detect { |r| r.type == "SOA" }
      end

      def replace_soa_serial soa_data, soa_serial
        soa_data = soa_data.split " "
        current_serial = soa_data[2].to_i
        soa_data[2] = if soa_serial && soa_serial.respond_to?(:call)
                        soa_serial.call current_serial
                      elsif soa_serial
                        soa_serial.to_i
                      else
                        current_serial + 1
                      end
        soa_data.join " "
      end

      def adjust_change_sort_order order
        return nil if order.nil?
        if order.to_s.downcase.start_with? "d"
          "descending"
        else
          "ascending"
        end
      end
    end
  end
end
