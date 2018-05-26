FactoryBot.define do
  factory :tip do
    association :event
    association :user

    point Random.rand(-30..30)
  end
end
