class SwaggerController < ApplicationController
  skip_before_action :authenticate_user

  def index
    render json: build_json
  end

  private

  def build_json
    root_dir = Rails.root.join('docs', 'swagger')
    json = YAML.load_file(root_dir.join('root.yml'))
    json['paths'] = {}
    Dir.glob(root_dir.join('paths/*')) do |path|
      json['paths'].merge!(YAML.load_file(path))
    end
    json['definitions'] = {}
    Dir.glob(root_dir.join('definitions/*')) do |path|
      json['definitions'].merge!(YAML.load_file(path))
    end
    json
  end
end
