require 'rails_helper'

RSpec.describe "Creators", type: :system do
  before do
    @creator = FactoryBot.build(:creator)
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報が入力できれば登録できる' do
      #トップページに遷移する
      visit root_path
      #サインアップページのボタンがあることを確認
      expect(page).to have_content('クリエイター新規登録')
      #新規投稿ページに移動
      visit new_creator_registration_path
      #ユーザー情報を入力する
      fill_in 'creator[email]', with: @creator.email
      fill_in 'creator[password]', with: @creator.password
      fill_in 'creator[password_confirmation]', with: @creator.password_confirmation
      fill_in 'creator[first_name]', with: @creator.first_name
      fill_in 'creator[last_name]', with: @creator.last_name
      fill_in 'creator[kana_first_name]', with: @creator.kana_first_name
      fill_in 'creator[kana_last_name]', with: @creator.kana_last_name
      find('select[name="creator[prefecture_id]"]').find("option[value='#{@creator.prefecture_id}']").select_option
      find('select[name="creator[birth_date(1i)]"]').find("option[value='#{@creator.birth_date.year}']").select_option
      find('select[name="creator[birth_date(2i)]"]').find("option[value='#{@creator.birth_date.mon}']").select_option
      find('select[name="creator[birth_date(3i)]"]').find("option[value='#{@creator.birth_date.mday}']").select_option
      #サインアップボタンを押すとクリエーターのモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Creator.count }.by(1)
      #トップページに遷移する
      expect(current_path).to eq root_path
      #ログアウトボタンがある
      expect(page).to have_content 'ログアウト'
      #サインアップページとログインページボタンがないことを確認する
      expect(page).to have_no_content 'クリエイター新規登録'
      expect(page).to have_no_content 'ログイン'
    end
  end

  context '新規登録できない' do
    it '入力に誤りがあると新規投稿ページに戻ってくる' do
      #トップページに遷移する
      visit root_path
      #サインアップページのボタンがあることを確認
      expect(page).to have_content('クリエイター新規登録')
      #新規投稿ページに移動
      visit new_creator_registration_path
      #ユーザー情報を入力する
      fill_in 'creator[email]', with: ''
      fill_in 'creator[password]', with: ''
      fill_in 'creator[password_confirmation]', with: ''
      fill_in 'creator[first_name]', with: ''
      fill_in 'creator[last_name]', with: ''
      fill_in 'creator[kana_first_name]', with:''
      fill_in 'creator[kana_last_name]', with: ''
      find('select[name="creator[prefecture_id]"]').find("option[value='#{@creator.prefecture_id}']").select_option
      find('select[name="creator[birth_date(1i)]"]').find("option[value='#{@creator.birth_date.year}']").select_option
      find('select[name="creator[birth_date(2i)]"]').find("option[value='#{@creator.birth_date.mon}']").select_option
      find('select[name="creator[birth_date(3i)]"]').find("option[value='#{@creator.birth_date.mday}']").select_option
      #サインアップボタンを押してもモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { Creator.count }.by(0)
      #新規登録ページへ戻される
      expect(current_path).to eq '/creators'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @creator = FactoryBot.create(:creator)
  end

  context 'ログインできる時' do
    it '保存している情報と一致すればログインできる' do
      #トップページに遷移する
      visit root_path
      #ログインボタンがあることを確かめる
      expect(page).to have_content 'クリエイターでログイン'
      #ログインページに遷移する
      visit new_creator_session_path
      #ユーザー情報を入力する
      fill_in 'creator[email]', with: @creator.email
      fill_in 'creator[password]', with: @creator.password
      #ログインボタンを押す
      find('input[name="commit"]').click
      #トップページに遷移する
      expect(current_path).to eq root_path
      #ログインボタンと新規登録ボタンがないことを確かめる
      expect(page).to have_content 'ログアウト'
      expect(page).to have_no_content 'クリエイターでログイン'
      expect(page).to have_no_content 'クリエイター新規登録'
    end
  end

  context 'ログインできない時' do
    it '入力が正しくない時' do 
      #トップページに遷移する
      visit root_path
      #ログインボタンがあることを確かめる
      expect(page).to have_content 'クリエイターでログイン'
      #ログインページに遷移する
      visit new_creator_session_path
      #ユーザー情報を誤って入力する
      fill_in 'creator[email]', with: ''
      fill_in 'creator[password]', with: ''
      #ログインボタンを押す
      find('input[name="commit"]').click
      #ログインページに戻される
      expect(current_path).to eq new_creator_session_path
    end
  end
end
