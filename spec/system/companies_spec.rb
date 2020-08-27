require 'rails_helper'

RSpec.describe "Companies", type: :system do
  before do
    @company = FactoryBot.build(:company)
  end

  context '法人新規登録できる' do
    it '正しく入力された時' do
      #トップページに遷移
      visit root_path
      #法人で新規登録ボタンがある
      expect(page).to have_content('法人で新規登録')
      #新規登録ページに遷移
      visit new_company_registration_path
      #入力事項を入力
      fill_in 'company[email]', with: @company.email
      fill_in 'company[password]', with: @company.password
      fill_in 'company[password_confirmation]', with: @company.password_confirmation
      fill_in 'company[name]', with: @company.name
      find('select[name="company[prefecture_id]"]').find("option[value='#{@company.prefecture_id}']").select_option
      #ボタンを押すとCompanyのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Company.count }.by(1)
      #トップページに遷移
      expect(current_path).to eq root_path
      #ログアウトボタンがある
      expect(page).to have_content 'ログアウト'
      #新規登録ボタンとログインボタンがない
      expect(page).to have_no_content '法人で新規登録'
      expect(page).to have_no_content 'ログイン'
    end
  end

  context '法人新規登録できない' do
    it '正しく入力されなかった' do
      #トップページに遷移
      visit root_path
      #法人で新規登録ボタンがある
      expect(page).to have_content('法人で新規登録')
      #新規登録ページに遷移
      visit new_company_registration_path
      #入力事項を入力
      fill_in 'company[email]', with: ''
      fill_in 'company[password]', with: @company.password
      fill_in 'company[password_confirmation]', with: @company.password_confirmation
      fill_in 'company[name]', with: @company.name
      find('select[name="company[prefecture_id]"]').find("option[value='#{@company.prefecture_id}']").select_option
      #ボタンを押すとCompanyのカウントが増えない
      expect{
        find('input[name="commit"]').click
      }.to change { Company.count }.by(0)
      #トップページに遷移する
      expect(current_path).to eq '/companies'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @company = FactoryBot.create(:company)
  end

  context 'ログインできる' do
    it '正しく入力される' do
      #トップページに遷移
      visit root_path
      #ログインボタンがあることを確認
      expect(page).to have_content '法人でログイン'
      #ログインページに遷移
      visit new_company_session_path
      #入力
      fill_in 'company[email]', with: @company.email
      fill_in 'company[password]', with: @company.password
      #クリック
      find('input[name="commit"]').click
      #トップページに遷移
      expect(current_path).to eq root_path
      #ログインボタンと新規登録ボタンがないことを確かめる
      expect(page).to have_content 'ログアウト'
      expect(page).to have_no_content '法人でログイン'
      expect(page).to have_no_content '法人で新規登録'
    end
  end

  context 'ログインできない' do
    it '入力が誤っている' do
      #トップページに遷移
      visit root_path
      #ログインボタンがあることを確認
      expect(page).to have_content '法人でログイン'
      #ログインページに遷移
      visit new_company_session_path
      #入力
      fill_in 'company[email]', with: ""
      fill_in 'company[password]', with: @company.password
      #クリック
      find('input[name="commit"]').click
      #ログインページに遷移
      expect(current_path).to eq new_company_session_path
    end
  end
end
