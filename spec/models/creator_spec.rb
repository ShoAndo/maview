require 'rails_helper'

RSpec.describe Creator, type: :model do
  before do
    @creator = FactoryBot.build(:creator)
  end

  describe 'クリエイター新規登録' do
    context '登録できる' do
      it '全てが形式通り入力されていると、登録できる' do
        expect(@creator).to be_valid
      end
      
      it 'passwordが6文字以上だと登録できる' do
        @creator.password = 'aaaaaa'
        @creator.password_confirmation = 'aaaaaa'
        expect(@creator).to be_valid
      end
      it '名字と名前の形式が正しければ登録できる' do
        @creator.last_name = '太郎'
        @creator.first_name = '山田'
        expect(@creator).to be_valid
      end
      it 'フリガナがカタカナであれば登録できる' do
        @creator.kana_first_name = 'ヤマダ'
        @creator.kana_last_name = 'タロウ'
        expect(@creator).to be_valid
      end
      it '生年月日が正しく入力されていれば登録できる' do
        @creator.birth_date = '2000-03-03'
        expect(@creator).to be_valid
      end
    end

    context '登録できない' do
      it 'prefecture_idが1だと登録できない' do
        @creator.prefecture_id = 1
        @creator.valid?
        expect(@creator.errors[:prefecture_id]).to include('を選択してください')
      end
      it 'emailが空だと登録できない' do
        @creator.email = ''
        @creator.valid?
        expect(@creator.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end
      it 'emailが重複していると登録できない' do
        @creator.save
        another_user = FactoryBot.build(:creator, email: @creator.email)
        another_user.valid?
        expect(another_user.errors.full_messages.join).to include(I18n.t('errors.messages.taken'))
      end
      it 'passwordが空だと登録できない' do
        @creator.password = ''
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.blank'))
      end
      it 'passeordが5文字以下だと登録できない' do
        @creator.password = 'aaaaa'
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.too_short', count: 6))
      end
      it 'passwordはあるが、password_confirmationが空だと登録できない' do
        @creator.password_confirmation = ''
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.confirmation', attribute: 'Password'))
      end
      it '名字が空だと登録できない' do
        @creator.first_name = ''
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.blank'))
      end
      it '名前が空だと登録できない' do
        @creator.last_name = ''
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.blank'))
      end
      it '名字が全角意外だと登録できない' do
        @creator.first_name = 'test'
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include('は全角で入力してください')
      end
      it '名前が全角漢字以外だと登録できない' do
        @creator.last_name = 'test'
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include('は全角で入力してください。')
      end
      it '名字のフリガナが空だと登録できない' do
        @creator.kana_first_name = ''
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.blank'))
      end
      it '名前のフリガナが空だと登録できない' do
        @creator.kana_last_name = ''
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include(I18n.t('errors.messages.blank'))
      end
      it '名字のフリガナがカタカナ以外だと登録できない' do
        @creator.kana_first_name = 'てすと'
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include('は全角カタカナで入力して下さい。')
      end
      it '名前のフリガナがカタカナ以外だと登録できない' do
        @creator.kana_last_name = 'てすと'
        @creator.valid?
        expect(@creator.errors.full_messages.join).to include('は全角カタカナで入力して下さい。')
      end
      it '生年月日が空だと登録できない' do
        @creator.birth_date = ''
        @creator.valid?
        expect(@creator.errors[:birth_date]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
