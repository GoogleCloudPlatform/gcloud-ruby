# Copyright 2016 Google Inc. All rights reserved.
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


require "google-cloud-spanner"
require "google/cloud/spanner/project"

module Google
  module Cloud
    ##
    # # Cloud Spanner
    #
    # Cloud Spanner is a fully managed, mission-critical, relational database
    # service that offers transactional consistency at global scale, schemas,
    # SQL (ANSI 2011 with extensions), and automatic, synchronous replication
    # for high availability.
    #
    # For more information about Cloud Spanner, read the [Cloud
    # Spanner Documentation](https://cloud.google.com/spanner/docs/).
    #
    # The goal of google-cloud is to provide an API that is comfortable to
    # Rubyists. Authentication is handled by {Google::Cloud#spanner}. You can
    # provide the project and credential information to connect to the Cloud
    # Spanner service, or if you are running on Google Compute Engine this
    # configuration is taken care of for you. You can read more about the
    # options for connecting in the [Authentication
    # Guide](https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/guides/authentication).
    #
    # ## Creating instances
    #
    # When you first use Cloud Spanner, you must create an instance, which is an
    # allocation of resources that are used by Cloud Spanner databases. When you
    # create an instance, you choose where your data is stored and how many
    # nodes are used for your data. (For more information, see [Instance
    # Configuration](https://cloud.google.com/spanner/docs/instance-configuration)).
    #
    # Use {Spanner::Project#create_instance} to create an instance:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # job = spanner.create_instance "my-instance",
    #                               name: "My Instance",
    #                               config: "regional-us-central1",
    #                               nodes: 5,
    #                               labels: { production: :env }
    #
    # job.done? #=> false
    # job.reload! # API call
    # job.done? #=> true
    # instance = job.instance
    # ```
    #
    # ## Creating databases
    #
    # Now that you have created an instance, you can create a database. Cloud
    # Spanner databases hold the tables and indexes that allow you to read and
    # write data. You may create multiple databases in an instance.
    #
    # Use {Spanner::Project#create_database} (or
    # {Spanner::Instance#create_database}) to create a database:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # job = spanner.create_database "my-instance", "my-database"
    #
    # job.done? #=> false
    # job.reload! # API call
    # job.done? #=> true
    # database = job.database
    # ```
    #
    # ## Updating database schemas
    #
    # Cloud Spanner supports schema updates to a database while the database
    # continues to serve traffic. Schema updates do not require taking the
    # database offline and they do not lock entire tables or columns; you can
    # continue writing data to the database during the schema update.
    #
    # Use {Spanner::Database#update} to execute one or more statements in Cloud
    # Spanner's Data Definition Language (DDL):
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # database = spanner.database "my-instance", "my-database"
    #
    # add_users_table_sql = %q(
    #   CREATE TABLE users (
    #     id INT64 NOT NULL,
    #     username STRING(25) NOT NULL,
    #     name STRING(45) NOT NULL,
    #     email STRING(128),
    #   ) PRIMARY KEY(id)
    # )
    #
    # database.update statements: [add_users_table_sql]
    # ```
    #
    # ## Creating clients
    #
    # In order to read and/or write data, you must create a database client.
    # You can think of a client as a database connection: All of your
    # interactions with Cloud Spanner data must go through a client. Typically
    # you create a client when your application starts up, then you re-use that
    # client to read, write, and execute transactions.
    #
    # Use {Spanner::Project#client} to create a client:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # db = spanner.client "my-instance", "my-database"
    #
    # results = db.execute "SELECT 1"
    #
    # results.rows.each do |row|
    #   puts row
    # end
    # ```
    #
    # ## Writing data
    #
    # You write data using your client object. The client object supports
    # various mutation operations, as well as combinations of inserts, updates,
    # deletes, etc., that can be applied atomically to different rows and/or
    # tables in a database.
    #
    # Use {Spanner::Client#commit} to execute various mutations atomically at a
    # single logical point in time. All changes are accumulated in memory until
    # the block completes. Unlike {Spanner::Client#transaction}, which can also
    # perform reads, this operation accepts only mutations and makes a single
    # API request.
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # db = spanner.client "my-instance", "my-database"
    #
    # db.commit do |c|
    #   c.update "users", [{ id: 1, username: "charlie94", name: "Charlie" }]
    #   c.insert "users", [{ id: 2, username: "harvey00", name: "Harvey" }]
    # end
    # ```
    #
    # ## Querying data using SQL
    #
    # Cloud Spanner supports a native SQL interface for reading data that is
    # available through {Spanner::Client#execute}:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # db = spanner.client "my-instance", "my-database"
    #
    # results = db.execute "SELECT * FROM users"
    #
    # results.rows.each do |row|
    #   puts "User #{row[:id]} is #{row[:name]}"
    # end
    # ```
    #
    # ## Reading data using the read method
    #
    # In addition to Cloud Spanner's SQL interface, Cloud Spanner also supports
    # a read interface. Use the {Spanner::Client#read} method to read rows from
    # the database, and use its `keys` option to pass unique identifiers as both
    # lists and ranges:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # db = spanner.client "my-instance", "my-database"
    #
    # results = db.read "users", [:id, :name], keys: 1..5
    #
    # results.rows.each do |row|
    #   puts "User #{row[:id]} is #{row[:name]}"
    # end
    # ```
    #
    # ## Using read-write transactions
    #
    # When an operation might write data depending on values it reads, you
    # should use a read-write transaction to perform the reads and writes
    # atomically.
    #
    # Suppose that sales of `Albums(1, 1)` are lower than expected and you want
    # to move $200,000 from the marketing budget of `Albums(2, 2)` to it, but
    # only if the budget of `Albums(2, 2)` is at least $300,000.
    #
    # Use {Spanner::Client#transaction} to execute both reads and writes
    # atomically at a single logical point in time. All changes are accumulated
    # in memory until the block completes. Transactions will be automatically
    # retried when possible. This operation makes separate API requests to begin
    # and commit the transaction.
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # db = spanner.client "my-instance", "my-database"
    #
    # db.transaction do |tx|
    #   # Read the second album budget.
    #   second_album_result = tx.read "Albums", ["marketing_budget"],
    #                                 keys: [[2, 2]], limit: 1
    #   second_album_row = second_album_result.rows.first
    #   second_album_budget = second_album_row.values.first
    #
    #   transfer_amount = 200000
    #
    #   if second_album_budget < 300000
    #     # Raising an exception will automatically roll back the transaction.
    #     raise "The second album doesn't have enough funds to transfer"
    #   end
    #
    #   # Read the first album's budget.
    #   first_album_result = tx.read "Albums", ["marketing_budget"],
    #                                 keys: [[1, 1]], limit: 1
    #   first_album_row = first_album_result.rows.first
    #   first_album_budget = first_album_row.values.first
    #
    #   # Update the budgets.
    #   second_album_budget -= transfer_amount
    #   first_album_budget += transfer_amount
    #   puts "Setting first album's budget to #{first_album_budget} and the " \
    #        "second album's budget to #{second_album_budget}."
    #
    #   # Update the rows.
    #   rows = [
    #     {singer_id: 1, album_id: 1, marketing_budget: first_album_budget},
    #     {singer_id: 2, album_id: 2, marketing_budget: second_album_budget}
    #   ]
    #   tx.update "Albums", rows
    # end
    # ```
    #
    # ## Using read-only transactions
    #
    # Suppose you want to execute more than one read at the same timestamp.
    # Read-only transactions observe a consistent prefix of the transaction
    # commit history, so your application always gets consistent data. Because
    # read-only transactions are much faster than locking read-write
    # transactions, we strongly recommend that you do all of your transaction
    # reads in read-only transactions if possible.
    #
    # Use a {Spanner::Snapshot} object to execute statements in a read-only
    # transaction. The snapshot object is available via a block provided to
    # {Spanner::Client#snapshot}:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # db = spanner.client "my-instance", "my-database"
    #
    # db.snapshot do |snp|
    #   results_1 = snp.execute "SELECT * FROM users"
    #   results_1.rows.each do |row|
    #     puts "User #{row[:id]} is #{row[:name]}"
    #   end
    #
    #   # Perform another read using the `read` method. Even if the data
    #   # is updated in-between the reads, the snapshot ensures that both
    #   # return the same data.
    #   results_2 = db.read "users", [:id, :name]
    #   results_2.rows.each do |row|
    #     puts "User #{row[:id]} is #{row[:name]}"
    #   end
    # end
    # ```
    #
    # ## Deleting databases
    #
    # Use {Spanner::Database#drop} to delete a database:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # database = spanner.database "my-instance", "my-database"
    #
    # database.drop
    # ```
    #
    # ## Deleting instances
    #
    # When you delete an instance, all databases within it are automatically
    # deleted. (If you only delete databases and not your instance, you will
    # still incur charges for the instance.) Use {Spanner::Instance#delete} to
    # delete an instance:
    #
    # ```ruby
    # require "google/cloud/spanner"
    #
    # spanner = Google::Cloud::Spanner.new
    #
    # instance = spanner.instance "my-instance"
    #
    # instance.delete
    # ````
    #
    module Spanner
      ##
      # Creates a new object for connecting to the Spanner service.
      # Each call creates a new connection.
      #
      # For more information on connecting to Google Cloud see the
      # [Authentication
      # Guide](https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/guides/authentication).
      #
      # @param [String] project Project identifier for the Spanner service you
      #   are connecting to.
      # @param [String, Hash] keyfile Keyfile downloaded from Google Cloud. If
      #   file path the file must be readable.
      # @param [String, Array<String>] scope The OAuth 2.0 scopes controlling
      #   the set of resources and operations that the connection can access.
      #   See [Using OAuth 2.0 to Access Google
      #   APIs](https://developers.google.com/identity/protocols/OAuth2).
      #
      #   The default scopes are:
      #
      #   * `https://www.googleapis.com/auth/spanner`
      #   * `https://www.googleapis.com/auth/spanner.data`
      # @param [Integer] timeout Default timeout to use in requests. Optional.
      # @param [Hash] client_config A hash of values to override the default
      #   behavior of the API client. Optional.
      #
      # @return [Google::Cloud::Spanner::Project]
      #
      # @example
      #   require "google/cloud/spanner"
      #
      #   spanner = Google::Cloud::Spanner.new
      #
      def self.new project: nil, keyfile: nil, scope: nil, timeout: nil,
                   client_config: nil
        project ||= Google::Cloud::Spanner::Project.default_project
        project = project.to_s # Always cast to a string
        fail ArgumentError, "project is missing" if project.empty?

        if keyfile.nil?
          credentials = Google::Cloud::Spanner::Credentials.default scope: scope
        else
          credentials = Google::Cloud::Spanner::Credentials.new(
            keyfile, scope: scope)
        end

        Google::Cloud::Spanner::Project.new(
          Google::Cloud::Spanner::Service.new(
            project, credentials, timeout: timeout,
                                  client_config: client_config))
      end
    end
  end
end
