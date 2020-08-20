require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '案件を提案できる' do
    context '提案できる' do
      it '正しい入力ができると提案できる' do
        expect(@order).to be_valid
      end
    end

    context '提案できない' do
      it 'タイトルが空だと登録できない' do
        @order.title = ''
        @order.valid?
        expect(@order.errors[:title]).to include(I18n.t('errors.messages.blank')) 
      end

      it 'コンテンツが空だと登録できない' do
        @order.content = ''
        @order.valid?
        expect(@order.errors[:content]).to include(I18n.t('errors.messages.blank'))
      end

      it '報酬が空だと登録できない' do
        @order.award = ''
        @order.valid?
        expect(@order.errors[:award]).to include(I18n.t('errors.messages.blank'))
      end

      it '報酬が300円以下だと登録できない' do
        @order.award = 200
        @order.valid?
        expect(@order.errors[:award]).to include('が可能な範囲を超えています')
      end

      it '応募締め切りが空だと登録できない' do
        @order.last_day = ''
        @order.valid?
        expect(@order.errors[:last_day]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end