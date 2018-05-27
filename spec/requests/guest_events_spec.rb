require 'rails_helper'

describe 'guest events API' do
  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /guest_events/:token' do
    let(:event) { FactoryBot.create(:guest_event) }
    before { get "/guest_events/#{event.token}" }

    specify do
      expect(status).to be 200
      expect(body).to eq({
        'token' => event.token,
        'title' => event.title,
        'description' => event.description,
        'date' => event.date.as_json,
        'created_at' => event.created_at.as_json,
      })
    end
  end

  describe 'POST /guest_events' do
    let(:params) { { title: 'foo', description: 'bar', date: '2018-10-10' } }
    before { post "/guest_events", params: params }

    specify do
      event = GuestEvent.take
      expect(status).to be 201
      expect(body).to eq({
        'token' => event.token,
        'title' => event.title,
        'description' => event.description,
        'date' => event.date.as_json,
        'created_at' => event.created_at.as_json,
      })
    end
  end

  describe 'PATCH /guest_events/:token' do
    let(:event) { FactoryBot.create(:guest_event) }
    before { patch "/guest_events/#{event.token}", params: { title: 'foo' } }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'result' => 'ok' })
      expect(event.reload.title).to eq 'foo'
    end
  end
end
