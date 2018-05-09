oauth_config = Rails.application.config_for(:omniauth).deep_symbolize_keys
google_config = oauth_config[:google]

OmniAuth.config.full_host = Rails.env.production? ? 'https://www.tolymer.com' : 'http://localhost:7700'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, google_config[:client_id], google_config[:secret], scope: 'profile', name: 'google'
end
