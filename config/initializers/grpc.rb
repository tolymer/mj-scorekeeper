module Grpc
end

grpc_libs = Rails.root.join('lib/proto')
$LOAD_PATH.unshift(grpc_libs.to_s)
Dir.glob(grpc_libs.join('**/*.rb')).each { |f| require f }
grpc_services = Rails.root.join('app/grpc/**/*.rb')
Dir.glob(grpc_services).each { |f| require f }
