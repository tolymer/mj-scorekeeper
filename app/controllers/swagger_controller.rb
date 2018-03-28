class SwaggerController < ApplicationController
  skip_before_action :authenticate_user

  def index
    render json: YAML.load_file(Rails.root.join('docs/swagger/index.yml'))
  end
end
