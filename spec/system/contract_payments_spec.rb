require 'rails_helper'

RSpec.describe "ContractPayments", type: :system do
  before do
    @creator = FactoryBot.create(:creator)
    @company = FactoryBot.create(:company)
    @order = FactoryBot.create(:order)
    @room = Room.create(name: '決済テスト', order_id: @order.id, creator_id: @creator.id, company_id: @company.id)
  end

  context '決済できる' do
    it '入力が正しいと決済できる', js: true do
      #ログイン
      sign_in(@company)
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      find_link(@room.name, href: order_room_messages_path(@order.id, @room.id)).click
      #契約するボタンを押す
      find_link('契約する', href: order_room_payments_path(@room.order_id, @room.id)).click
      #入力する
      number = '4242424242424242'
      exp_month = '12'
      exp_year = '24'
      cvc = '123'
      fill_in 'number', with: number
      fill_in 'exp_month', with: exp_month
      fill_in 'exp_year', with: exp_year
      fill_in 'cvc', with: cvc
      expect{
        all('.buy-btn')[0].find('input[name="commit"]').click
        sleep(2)
      }.to change { Contract.count }.by(1)
      expect(current_path).to eq root_path
    end

    it '登録したカードでなら入力せずに決済できる' do
      #ログイン
      sign_in(@company)
      #マイページに遷移
      find_link(@company.name, href: company_path(@company) ).click
      #カード編集ページに遷移
      find_link('編集する', href: new_company_card_path(@company)).click
      #入力する
      fill_in 'number', with: '4242424242424242'
      fill_in 'cvc', with: '123'
      find('select[name="exp_month"]').find('option[value="12"]').select_option
      find('select[name="exp_year"]').find('option[value="24"]').select_option
      expect{
        find('input[name="commit"]').click
        sleep(2)
      }.to change { Card.count }.by(1)
      #トップページに戻る
      expect(current_path).to eq root_path
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      find_link(@room.name, href: order_room_messages_path(@order.id, @room.id)).click
      #契約するボタンを押す
      find_link('契約する', href: order_room_payments_path(@room.order_id, @room.id)).click
      #ボタンを押す
      expect{
        all('.buy-btn')[1].find('input[name="commit"]').click
        sleep(2)
      }.to change { Contract.count }.by(1)
      expect(current_path).to eq root_path
    end
  end

  context '決済できない' do
    it '入力が正しくないと決済できない' do
      #ログイン
      sign_in(@company)
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      find_link(@room.name, href: order_room_messages_path(@order.id, @room.id)).click
      #契約するボタンを押す
      find_link('契約する', href: order_room_payments_path(@room.order_id, @room.id)).click
      #入力
      fill_in 'number', with: ''
      fill_in 'exp_month', with: ''
      fill_in 'exp_year', with: ''
      fill_in 'cvc', with: ''
      expect{
        all('.buy-btn')[0].find('input[name="commit"]').click
      }.not_to change { Contract.count }
      expect(current_path).to eq order_room_payments_path(@room.order_id, @room.id)
    end
  end
end
