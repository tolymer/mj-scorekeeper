Dir.glob(File.expand_path("../schema/*", __FILE__)).each do |path|
  require path
end
