class OrdersController < ApplicationController
  before_action :move_to_index, only: :new

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def move_to_index
    unless company_signed_in?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order).permit(:title, :content, :last_day, :deadline, :award).merge(company_id: current_company.id)
  end
end
