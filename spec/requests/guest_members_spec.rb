require 'rails_helper'

describe 'guest members API' do
  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /guest_events/:token/guest_members' do
    let(:event) { FactoryBot.create(:guest_event) }
    let!(:member1) { FactoryBot.create(:guest_member, event: event) }
    let!(:member2) { FactoryBot.create(:guest_member, event: event) }

    before do
      get "/guest_events/#{event.token}/guest_members"
    end

    specify do
      expect(status).to be 200
      expect(body).to contain_exactly(
        { 'id' => member1.id, 'name' => member1.name },
        { 'id' => member2.id, 'name' => member2.name }
      )
    end
  end

  describe 'POST /guest_events/:token/guest_members' do
    let(:event) { FactoryBot.create(:guest_event) }

    before { post "/guest_events/#{event.token}/guest_members", params: { names: ['foo', 'bar'] } }

    specify do
      expect(status).to be 201
      expect(body).to eq({ 'result' => 'ok' })
      expect(event.members.size).to eq 2
    end
  end
end
