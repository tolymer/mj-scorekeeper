FactoryBot.define do
  factory :game_score do
    association :game
    association :user
    point Random.rand(-75..75)
    rank Random.rand(1..4)
  end
end
