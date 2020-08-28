require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = FactoryBot.build(:card)
  end

  context '保存できる' do
    it '全て存在すれば保存できる' do
      expect(@card).to be_valid
    end
  end

  context '保存できない' do
    it 'card_tokenが空だと保存できる' do
      @card.card_token = nil
      @card.valid?
      expect(@card.errors[:card_token]).to include(I18n.t('errors.messages.blank'))
    end

    it 'customer_tokenが空だと保存できない' do
      @card.customer_token = ''
      @card.valid?
      expect(@card.errors[:customer_token]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
