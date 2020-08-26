FactoryBot.define do
  factory :message do
    content { 'こんにちは' }
    category { 'creator' }
    association :room

    after(:build) do |order|
      order.image.attach(io: File.open('spec/fixture/kanazawa1.jpg'), filename: 'kanazawa1.jpg', content_type: 'image/jpg')
    end
  end
end
