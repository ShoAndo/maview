class RoomsController < ApplicationController
  before_action :find_order, only: [:new, :create, :destroy]

  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to order_room_messages_path(order_id: @order.id, room_id: @room.id)
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to item_rooms_path(@item.id)
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def room_params
    params.require(:room).permit(:name).merge(creator_id: params[:room][:creator_id], company_id: params[:room][:company_id], order_id: @order.id)
  end
end
