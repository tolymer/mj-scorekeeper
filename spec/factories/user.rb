FactoryBot.define do
  factory :user do
    name { "name_#{id}" }
  end
end
