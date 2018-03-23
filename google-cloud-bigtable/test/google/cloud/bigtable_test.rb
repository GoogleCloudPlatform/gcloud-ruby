require "test_helper"

describe Google::Cloud do
  describe "#bigtable" do
    let(:found_credentials) { "{}" }
    let(:default_credentials) { "{}" }

    def self.it_create_new_client_and_validate(client_type, client_class, keyfile: nil, instance_id: nil)
      it "passes #{keyfile && "keyfile"} to Google::Cloud.bigtable to get #{client_class.name}" do
        gcloud = Google::Cloud.new("project-id", keyfile)

        File.stub :file?, true, ["path/to/keyfile.json"] do
          File.stub :read, found_credentials, ["path/to/keyfile.json"] do
            Google::Cloud::Bigtable::Credentials.stub :default, default_credentials do
              client = gcloud.bigtable(client_type: client_type, instance_id: instance_id)
              assert_instance_of(client_class, client)
              assert_equal("project-id", client.project_id)
              assert_nil(client.options[:scopes])
              assert_nil(client.options[:client_config])
              assert_nil(client.options[:timeout])

              yield self, client if block_given?
            end
          end
        end
      end
    end

    it_create_new_client_and_validate(:instance, Google::Cloud::Bigtable::InstanceAdminClient) do |t, client|
      t.assert_equal("{}", client.options[:credentials])
    end

    it_create_new_client_and_validate(:instance, Google::Cloud::Bigtable::InstanceAdminClient, keyfile: "keyfile-path") do |t, client|
      t.assert_equal("keyfile-path", client.options[:credentials])
    end

    it_create_new_client_and_validate(:table, Google::Cloud::Bigtable::TableAdminClient, instance_id: "instance-id") do |t, client|
      t.assert_equal("{}", client.options[:credentials])
      t.assert_equal("instance-id", client.instance_id)
    end

    it_create_new_client_and_validate(:table, Google::Cloud::Bigtable::TableAdminClient, keyfile: "keyfile-path", instance_id: "instance-id") do |t, client|
      t.assert_equal("keyfile-path", client.options[:credentials])
      t.assert_equal("instance-id", client.instance_id)
    end
  end
end
