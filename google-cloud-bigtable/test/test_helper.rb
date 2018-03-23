require "minitest/autorun"
require "minitest/spec"
require "minitest/autorun"
require "minitest/focus"
require "minitest/rg"

require "google/cloud"
require "google/cloud/bigtable"
require "google/cloud/bigtable/admin/credentials"

class MockBigtableAdminCredentials < Google::Cloud::Bigtable::Admin::Credentials
  def initialize method_name
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
        "happen since the grpc layer is being mocked."
    end
  end
end

# Mock for the GRPC::ClientStub class.
class MockGrpcClientStub

  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize(expected_symbol, mock_method)
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren't being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method(symbol)
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

# Create expected grpc response for long running operation
def build_longrunning_operation(name, expected_response, protobuf_class)
  response = Google::Gax::to_proto(expected_response, protobuf_class)

  result = Google::Protobuf::Any.new
  result.pack(response)
  operation = Google::Longrunning::Operation.new(
    name: "operations/#{name}_test",
    done: true,
    response: result
  )

  return [operation, response]
end

def build_longrunning_operation_with_error(name, klass)
  operation_error = Google::Rpc::Status.new(
    message: "Operation error for #{klass}\##{name}"
  )

  operation = Google::Longrunning::Operation.new(
    name: "operations/#{name}_test",
    done: true,
    error: operation_error
  )

  return [operation, operation_error]
end
