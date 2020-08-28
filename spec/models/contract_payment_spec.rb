require 'rails_helper'

RSpec.describe ContractPayment, type: :model do
  before do
    @contract_payment = FactoryBot.build(:contract_payment)
  end

  context '決済できる' do
    it '全て存在すれば保存できる' do
      expect(@contract_payment).to be_valid
    end
  end

  context '決済できない' do
    it 'priceが存在しないと保存できない' do
      @contract_payment.price = ''
      @contract_payment.valid?
      expect(@contract_payment.errors[:price]).to include(I18n.t('errors.messages.blank'))
    end
  end
end