require 'rails_helper'

describe GameScore do
  describe '#rank' do
    it 'should be 1, 2, 3 or 4' do
      [*1..4].each {|r|
        game_score = FactoryBot.build(:game_score, { rank: r })
        expect(game_score.valid?).to be true
      }
    end

    it 'should not be less than 1' do
      game_score = FactoryBot.build(:game_score, { rank: 0 })
      expect(game_score.valid?).to be false
    end

    it 'should not be greater than 4' do
      game_score = FactoryBot.build(:game_score, { rank: 5 })
      expect(game_score.valid?).to be false
    end
  end

  describe '#point' do
    it 'should be integer value' do
      [-10, 0, 42].each {|p|
        game_score = FactoryBot.build(:game_score, { point: p })
        expect(game_score.valid?).to be true
      }
    end

    it 'should not be float value' do
      game_score = FactoryBot.build(:game_score, { point: 0.1 })
      expect(game_score.valid?).to be false
    end

    it 'should not be string' do
      game_score = FactoryBot.build(:game_score, { point: 'hoge' })
      expect(game_score.valid?).to be false
    end
  end
end
