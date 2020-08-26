FactoryBot.define do
  factory :room do
    name  {'サンプル'}
    association :creator
    association :company
    association :order
  end
end
