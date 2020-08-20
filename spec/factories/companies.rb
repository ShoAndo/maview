FactoryBot.define do
  factory :company do
    name                  { '株式会社サンプル' }
    prefecture_id         { 14 }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end