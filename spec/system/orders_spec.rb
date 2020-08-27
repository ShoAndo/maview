require 'rails_helper'

RSpec.describe "案件投稿", type: :system do
  before do
    @company = FactoryBot.create(:company)
    @order = FactoryBot.build(:order)
  end

  context '案件を投稿できる' do
    it '正しく入力すると投稿できる' do
      #ログインする
      visit new_company_session_path
      fill_in 'company[email]', with: @company.email
      fill_in 'company[password]', with: @company.password
      find('input[name="commit"]').click
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
      visit new_company_session_path
      fill_in 'company[email]', with: @order1.company.email
      fill_in 'company[password]', with: @order1.company.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      #投稿した案件の詳細リンクがある
      expect(
        all('.order-list')[1]
      ).to have_link @order1.title, href: order_path(@order1)
      #詳細ページをクリック
      visit order_path(@order1)
      #編集ボタンがある
      expect('.order-red-btn').to have_link '案件の編集', href: edit_order_path(@order1)
      #編集ページに遷移
      visit edit_order_path(@order1)
      

    end
  end

  context '編集できない' do
    it '投稿したユーザー出ないと編集できない' do
    end
  end
end