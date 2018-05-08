class UserTokenController < ApplicationController
  skip_before_action :authenticate_user

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_by_auth_hash(auth_hash)
    auth_token = Knock::AuthToken.new(payload: { sub: user.id })
    render json: auth_token, status: :created
  end
end
