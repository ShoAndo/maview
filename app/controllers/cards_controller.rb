class CardsController < ApplicationController
  before_action :find_company, only: [:new, :create]

  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer = Payjp::Customer.create(
    description: 'test', # テストカードであることを説明
    card: params[:card_token] # 登録しようとしているカード情報
    )
    card = Card.new( # トークン化されたカード情報を保存する
      card_token: params[:card_token], # カードトークン
      customer_token: customer.id, # 顧客トークン
      company_id: @company.id # ログインしているユーザー
    )
    if card.save
      redirect_to root_path
    else
      redirect_to "new" # カード登録画面
    end
  end
  private

  def find_company
    @company = Company.find(params[:company_id])
  end

end
