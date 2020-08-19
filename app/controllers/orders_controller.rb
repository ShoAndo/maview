class OrdersController < ApplicationController
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

  def order_params
    params.require(:order).permit(:title, :content, :last_day, :deadline, :award).merge(company_id: current_company.id)
  end
end
