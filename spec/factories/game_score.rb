FactoryBot.define do
  factory :game_score do
    association :user
    association :game
  end
end

