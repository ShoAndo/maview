require 'rails_helper'

RSpec.describe "案件投稿", type: :system do
  before do
    @company = FactoryBot.create(:company)
    @order = FactoryBot.build(:order)
  end

  context '案件を投稿できる' do
    it '正しく入力すると投稿できる' do
      #ログインする
      sign_in(@company)
      #投稿ページがあることを確認
      expect(page).to have_content '案件を提案する'
      #投稿ページに移動する
      visit new_order_path
      #入力する
      fill_in 'order[title]', with: @order.title
      fill_in 'order[content]', with: @order.content
      find('select[name="order[last_day(1i)]"]').find("option[value='#{@order.last_day.year}']").select_option
      find('select[name="order[last_day(2i)]"]').find("option[value='#{@order.last_day.mon}']").select_option
      find('select[name="order[last_day(3i)]"]').find("option[value='#{@order.last_day.mday}']").select_option
      find('select[name="order[deadline(1i)]"]').find("option[value='#{@order.deadline.year}']").select_option
      find('select[name="order[deadline(2i)]"]').find("option[value='#{@order.deadline.mon}']").select_option
      find('select[name="order[deadline(3i)]"]').find("option[value='#{@order.deadline.mday}']").select_option
      find('select[name="order[job_category_id]"]').find("option[value='#{@order.job_category_id}']").select_option
      fill_in 'order[award]', with: @order.award
      #投稿するとOrderモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Order.count }.by(1)
      #トップページにいることを確認
      expect(current_path).to eq root_path
      #投稿したものがあることを確認
      expect(page).to have_content @order.title
    end
  end

  context '案件を投稿できない' do
    it '誤って入力すると投稿できない' do
      #トップページに行く
      visit root_path
      #投稿ボタンがない
      expect(page).to have_no_content '案件を提案する'
    end
  end
end

RSpec.describe '案件の編集', type: :system do
  before do
    @order1 = FactoryBot.create(:order)
    @order2 = FactoryBot.create(:order)
  end
  context '編集できる' do
    it '投稿したユーザーは編集できる' do
      #order1を投稿したCompanyでログインする
      sign_in(@order1.company)
      #投稿した案件の詳細リンクがある
      expect(
        all('.order-list')[1]
      ).to have_link @order1.title, href: order_path(@order1)
      #詳細ページをクリック
      visit order_path(@order1)
      #編集ボタンがある
      expect(page).to have_content '案件の編集'
      #編集ページに遷移
      visit edit_order_path(@order1)
      #編集
      fill_in 'order[title]', with: '編集'
      fill_in 'order[content]', with: '編集編集'
      #保存ボタンを押してもモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Order.count }.by(0)
      #トップページに遷移
      expect(current_path).to eq root_path
      #編集が適応されている
      expect(
        all('.order-list')[1]
      ).to have_link '編集', href: order_path(@order1)
    end
  end

  context '編集できない' do
    it '投稿したユーザー出ないと編集できない' do
      #トップページに遷移
      visit root_path
      #投稿した案件の詳細リンクがある
      expect(
        all('.order-list')[1]
      ).to have_link @order1.title, href: order_path(@order1)
      #詳細ページをクリック
      visit order_path(@order1)
      #編集ボタンがない
      expect(page).to have_no_content '案件の編集'
    end
  end
end

RSpec.describe '削除機能' do
  before do
    @order1 = FactoryBot.create(:order)
    @order2 = FactoryBot.create(:order)
  end

  context '削除できる' do
    it 'ログインしたユーザーは削除できる' do
      #order1を投稿したCompanyでログインする
      sign_in(@order1.company)
      #投稿した案件の詳細リンクがある
      expect(
        all('.order-list')[1]
      ).to have_link @order1.title, href: order_path(@order1)
      #詳細ページをクリック
      visit order_path(@order1)
      #削除ボタンがある
      expect(page).to have_content '削除'
      #削除ボタンをすとカウントがへる
      expect{
        find_link( '削除', href: order_path(@order1)).click
      }.to change { Order.count }.by(-1)
      #トップページにいる
      expect(current_path).to eq root_path
      #削除した案件はページにない
      expect(
        all('.order-list')
      ).to have_no_link @order1.title, href: order_path(@order1)
    end
  end

  context '削除できない' do
    it '投稿していないユーザーは削除できない' do
      #order1を投稿したCompanyでログインする
      sign_in(@order1.company)
      #投稿した案件の詳細リンクがある
      expect(
        all('.order-list')[0]
      ).to have_link @order2.title, href: order_path(@order2)
      #詳細ページをクリック
      visit order_path(@order2)
      #削除ボタンがない
      expect(page).to have_no_content '削除'
    end

    it 'ログインしていないユーザーは削除できない' do
      #トップページに遷移
      visit root_path
      #投稿した案件の詳細リンクがある
      expect(
        all('.order-list')[0]
      ).to have_link @order2.title, href: order_path(@order2)
      #詳細ページをクリック
      visit order_path(@order2)
      #削除ボタンがない
      expect(page).to have_no_content '削除'
    end
  end
end