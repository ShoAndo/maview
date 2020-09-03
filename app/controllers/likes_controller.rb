class LikesController < ApplicationController
  before_action :find_order

  def create
    @like = Like.create(creator_id: current_creator.id, order_id: @order.id)
    redirect_to orders_path
  end

  def destroy
    @like = Like.find_by(creator_id: current_creator.id, order_id: @order.id)
    @like.destroy
    redirect_to orders_path
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end
end
