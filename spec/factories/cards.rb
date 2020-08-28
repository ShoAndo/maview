FactoryBot.define do
  factory :card do
    card_token { 'tok_0268129036189230741361093713198365'}
    customer_token { 'cus_dsjfbvlairuailrbavldjvabkfsvair' }
    association :company
  end
end
