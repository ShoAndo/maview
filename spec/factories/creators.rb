FactoryBot.define do
  factory :creator do
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { '名字' }
    last_name             { '名前' }
    kana_first_name       { 'ミョウジ' }
    kana_last_name        { 'ナマエ' }
    birth_date            { Faker::Date.between(from: '1990-01-01', to: '2020-08-03') }
    prefecture_id         { 14 }
  end
end