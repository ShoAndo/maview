require 'rails_helper'

RSpec.describe "Messages", type: :system do
  before do
    @order = FactoryBot.create(:order)
    @creator = FactoryBot.create(:creator)
    @company = FactoryBot.create(:company)
    @room = FactoryBot.build(:room)
    @room.order_id = @order.id
    @room.creator_id = @creator.id
    @room.company_id = @company.id
    @room.save
  end

  context 'メッセージを送れる' do
    it '画像が送れる場合' do
      #ログインする
      creator_sign_in(@creator)
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      click_on(@room.name)
      #送信する画像を用意
      image_path = Rails.root.join('spec/fixture/kanazawa1.jpg')
      #画像を添付
      attach_file('message[image]', image_path, make_visible: true)
      #送信するとカウントが一つ増える
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      #投稿一覧画面にいる
      expect(current_path).to eq order_room_messages_path(@order, @room)

      #投稿した内容がある
      expect(page).to have_selector('img')
    end

    it 'メッセージと画像の送信に成功する' do
      #ログインする
      creator_sign_in(@creator)
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      click_on(@room.name)
      #送信する画像を用意
      image_path = Rails.root.join('spec/fixture/kanazawa1.jpg')
      #画像を添付
      attach_file('message[image]', image_path, make_visible: true)
      #メッセージを用意
      post = 'こんにちは'
      fill_in 'message[content]', with: post

      #送信したらカウントが上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      #投稿一覧画面にいる
      expect(current_path).to eq order_room_messages_path(@order, @room)

      #投稿した内容がある
      expect(page).to have_content(post)
      expect(page).to have_selector('img')
    end

    it 'テキストを送信できる' do
      #ログインする
      creator_sign_in(@creator)
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      click_on(@room.name)
      #メッセージを用意
      post = 'こんにちは'
      fill_in 'message[content]', with: post

      #送信したらカウントが上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      #投稿一覧画面にいる
      expect(current_path).to eq order_room_messages_path(@order, @room)

      #投稿した内容がある
      expect(page).to have_content(post)
    end
  end

  context 'メッセージを送れない' do
    it '送る値が空の時送信に失敗する' do
      #ログインする
      creator_sign_in(@creator)
      #メッセージに遷移
      find_link('メッセージ', href: rooms_path).click
      #ルームに移動
      click_on(@room.name)
      #空のまま送信する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Message.count }
      #元のページに戻ってくる
      expect(current_path).to eq order_room_messages_path(@order, @room)
    end
  end

end
