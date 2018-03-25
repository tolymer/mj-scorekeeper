FactoryBot.define do
  factory :user do
    name { "name_#{id}" }
    password_digest { 'xxx' }
  end
end
