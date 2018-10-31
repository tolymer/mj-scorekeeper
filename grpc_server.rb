class ClearConnectionInterceptor < GRPC::Interceptor
  def request_response(*)
    Rails.application.executor.wrap do
      ActiveRecord::Base.connection_pool.with_connection do
        yield
      end
    end
  end

  alias_method :server_streamer, :request_response
  alias_method :client_streamer, :request_response
  alias_method :bidi_streamer, :request_response
end

class GrpcServer
  PORT = '0.0.0.0:5000'

  def initialize
    @server = GRPC::RpcServer.new(interceptors: [ClearConnectionInterceptor.new])
    @server.add_http2_port(PORT, :this_port_is_insecure) # FIXME
  end

  def set_handler(handler_klass)
    @server.handle(handler_klass.new)
  end

  def run
    puts "Starting to listen: #{PORT}"

    @server.run
  end
end

server = GrpcServer.new
Grpc.constants.each do |svc|
  puts "Setting up GRPC Service: #{svc}"
  server.set_handler "Grpc::#{svc.to_s.camelize}".constantize
end

server.run
