FactoryBot.define do
  factory :contract_payment do
    price { 10000 }
    creator_id { 1 }
    company_id { 1 }
    order_id { 1 }
  end
end