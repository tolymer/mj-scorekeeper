FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "user_#{n}" }
    password_digest { 'xxx' }
  end
end
