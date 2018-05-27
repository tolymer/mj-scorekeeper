require 'rails_helper'

describe 'tips API' do
  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  let(:event) { FactoryBot.create(:guest_event) }
  let(:member1) { FactoryBot.create(:guest_member) }
  let(:member2) { FactoryBot.create(:guest_member) }
  let(:member3) { FactoryBot.create(:guest_member) }
  let(:member4) { FactoryBot.create(:guest_member) }

  describe 'GET /guest_events/:token/guest_tip' do
    let(:now) { Time.now }

    before do
      event.tips.create!(member: member1, point: 10)
      event.tips.create!(member: member2, point: -10)
      event.tips.create!(member: member3, point: 20)
      event.tips.create!(member: member4, point: -20)

      get "/guest_events/#{event.token}/guest_tips"
    end

    specify do
      expect(status).to be 200
      expect(body).to contain_exactly(
        { 'member_id' => member1.id, 'point' => 10 },
        { 'member_id' => member2.id, 'point' => -10 },
        { 'member_id' => member3.id, 'point' => 20 },
        { 'member_id' => member4.id, 'point' => -20 },
      )
    end
  end

  describe 'POST /guest_events/:token/guest_tips' do
    let(:params) do
      {
        tips: [
          { member_id: member1.id, point: 10 },
          { member_id: member2.id, point: -10 },
          { member_id: member3.id, point: 30 },
          { member_id: member4.id, point: -30 },
        ]
      }
    end

    specify do
      post "/guest_events/#{event.token}/guest_tips", params: params

      expect(status).to be 200
      expect(event.tips.size).to be 4

      member1_tip = event.tips.find_by(member_id: member1.id)
      expect(member1_tip.point).to eq 10

      member2_tip = event.tips.find_by(member_id: member2.id)
      expect(member2_tip.point).to eq(-10)

      member3_tip = event.tips.find_by(member_id: member3.id)
      expect(member3_tip.point).to eq 30

      member4_tip = event.tips.find_by(member_id: member4.id)
      expect(member4_tip.point).to eq(-30)
    end

    context 'when tips are already exist' do
      before do
        event.tips.create!(member: member1, point: 1)
        event.tips.create!(member: member2, point: -1)
        event.tips.create!(member: member3, point: 2)
        event.tips.create!(member: member4, point: -2)
      end

      it 'should override data' do
        post "/guest_events/#{event.token}/guest_tips", params: params

        expect(status).to be 200
        expect(event.tips.size).to be 4

        member1_tip = event.tips.find_by(member_id: member1.id)
        expect(member1_tip.point).to eq 10

        member2_tip = event.tips.find_by(member_id: member2.id)
        expect(member2_tip.point).to eq(-10)

        member3_tip = event.tips.find_by(member_id: member3.id)
        expect(member3_tip.point).to eq 30

        member4_tip = event.tips.find_by(member_id: member4.id)
        expect(member4_tip.point).to eq(-30)
      end
    end
  end
end
