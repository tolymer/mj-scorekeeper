require 'rails_helper'

describe 'events API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /groups/:group_id/events' do
    let(:event) { FactoryBot.create(:event) }
    before { get "/groups/#{event.group.id}/events", headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq([{
        'id' => event.id,
        'title' => event.title,
        'date' => event.date.as_json,
        'group_id' => event.group_id,
        'created_at' => event.created_at.as_json,
      }])
    end
  end

  describe 'GET /events/:id' do
    let(:event) { FactoryBot.create(:event) }
    before { get "/events/#{event.id}", headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq({
        'id' => event.id,
        'title' => event.title,
        'date' => event.date.as_json,
        'group_id' => event.group_id,
        'created_at' => event.created_at.as_json,
      })
    end
  end

  describe 'POST /groups/:group_id/events' do
    let(:group) { FactoryBot.create(:group) }
    let(:params) { { title: 'foo', date: '2018-10-10' } }
    before { post "/groups/#{group.id}/events", params: params, headers: headers }

    specify do
      event = Event.take
      expect(event.title).to eq params[:title]
      expect(status).to be 201
      expect(body).to eq({
        'id' => event.id,
        'title' => event.title,
        'date' => event.date.as_json,
        'group_id' => event.group_id,
        'created_at' => event.created_at.as_json,
      })
    end
  end
end
