require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'メッセージ投稿' do
    before do
      @message = FactoryBot.build(:message)
    end
    context 'メッセージ投稿できる' do
      it '形式が正しいと投稿できる' do
        expect(@message).to be_valid
      end
      it '写真があれば投稿できる' do
        @message.content = ''
        expect(@message).to be_valid
      end
      it '内容があれば投稿できる' do
        @message.image = nil
        expect(@message).to be_valid
      end
    end
    context 'メッセージ投稿できない' do
      it 'contentとimageが空だと投稿できない' do
        @message.content = nil
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages.join).to include(I18n.t('errors.messages.blank'))
      end

      it 'categoryが空だと投稿できない' do
        @message.category = ''
        @message.valid?
        expect(@message.errors[:category]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
