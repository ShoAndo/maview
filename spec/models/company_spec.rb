require 'rails_helper'

RSpec.describe Company, type: :model do
  before do
    @company = FactoryBot.build(:company)
  end

  describe 'カンパニー新規登録' do
    context '新規登録できる' do
      it '全て正しく記述されていれば登録できる' do
        expect(@company).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @company.password = "sample1234"
        @company.password_confirmation = @company.password
        expect(@company).to be_valid
      end
    end

    context '新規登録できない' do
      it 'nameが空だと登録できない' do
        @company.name = ""
        @company.valid?
        expect(@company.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end

      it 'prefecture_idが空だと登録できない' do
        @company.prefecture_id = ''
        @company.valid?
        expect(@company.errors[:prefecture_id]).to include('を選択してください')
      end

      it 'prefecture_idが1だと登録できない' do
        @company.prefecture_id = 1
        @company.valid?
        expect(@company.errors[:prefecture_id]).to include('を選択してください')
      end

      it 'emailが空だと登録できない' do
        @company.email = ''
        @company.valid?
        expect(@company.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end

      it 'emailが重複していると登録できない' do
        @company.save
        another_user = FactoryBot.build(:company, email: @company.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include(I18n.t('errors.messages.taken'))
      end

      it 'passwordが空だと登録できない' do
        @company.password = ''
        @company.valid?
        expect(@company.errors[:password]).to include(I18n.t('errors.messages.blank'))
      end

      it 'passwordが5文字以下だと登録できない' do
        @company.password = 'aaaaa'
        @company.valid?
        expect(@company.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 6))
      end

      it 'password_confirmationが空だと登録できない' do
        @company.password_confirmation = ''
        @company.valid?
        expect(@company.errors[:password_confirmation]).to include(I18n.t('errors.messages.confirmation', attribute: 'Password'))
      end
    end
  end
end
