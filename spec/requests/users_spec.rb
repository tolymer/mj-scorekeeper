require 'rails_helper'

describe 'users API' do
  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /users/:id' do
    let(:user) { FactoryBot.create(:user) }
    before { get "/users/#{user.id}" }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'id' => user.id, 'name' => user.name })
    end
  end

  describe 'POST /users' do
    before { post "/users", params: { name: 'foo', password: 'bar' }, headers: headers  }

    specify do
      user = User.take
      expect(status).to be 201
      expect(body).to eq({ 'id' => user.id, 'name' => user.name })
    end
  end
end
