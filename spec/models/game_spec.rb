require 'rails_helper'

describe Game do
  def create_game(scores)
    game = FactoryBot.create(:game)

    scores.map { |s|
      FactoryBot.create(:game_score, { game:  game }.merge(s))
    }

    game
  end

  let(:game) {
    create_game [
      { point: 10,  rank: 2 },
      { point: -20, rank: 3 },
      { point: 50,  rank: 1 },
      { point: -40, rank: 4 },
    ]
  }

  let(:invalid_score_game) {
    # 合計が0でない
    create_game [
      { point: 0,   rank: 2 },
      { point: -20, rank: 3 },
      { point: 50,  rank: 1 },
      { point: -40, rank: 4 },
    ]
  }

  let(:invalid_rank_game) {
    # rankが実態と合致していない
    create_game [
      { point: 10,  rank: 1 },
      { point: -20, rank: 2 },
      { point: 50,  rank: 3 },
      { point: -40, rank: 4 },
    ]
  }

  describe 'valid?' do
    context 'normal game' do
      it 'should return true' do
        expect(game.valid?).to be true
      end
    end

    context 'scores summary is not zero' do
      it 'should return false' do
        expect(invalid_score_game.valid?).to be false
      end
    end

    context 'ranking order is invalid' do
      it 'should return false' do
        expect(invalid_rank_game.valid?).to be false
      end
    end
  end

end
