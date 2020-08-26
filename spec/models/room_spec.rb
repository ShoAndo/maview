require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end

  describe 'ルーム作成' do
    context 'ルーム作成できる' do
      it '形式が正しいと作成できる' do
        expect(@room).to be_valid
      end
    end

    context 'ルーム作成できない' do
      it 'nameが空白だと作成できない' do
        @room.name = ''
        @room.valid?
        expect(@room.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
