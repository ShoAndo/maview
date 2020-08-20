FactoryBot.define do
  factory :order do
    title      { 'サンプル' }
    content    { 'サンプル' }
    award      { 10000 }
    last_day   { Faker::Date.between(from: '2020-08-01', to: '2020-08-31') } 
    deadline   { Faker::Date.between(from: '2020-09-01', to: '2020-10-01') }
    association :company
  end
end
