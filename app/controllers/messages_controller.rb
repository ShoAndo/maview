class MessagesController < ApplicationController
  before_action :move_to_index 
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to order_room_messages_path(@room.order_id, @room.id)
    else
      @messages = @room.messages
      render :index
    end
  end

  private

  def move_to_index
    unless company_signed_in? or creator_signed_in?
      redirect_to root_path
    end
  end

  def message_params
    params.require(:message).permit(:content, :image, :category)
  end
end
