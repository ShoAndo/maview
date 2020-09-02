class MessagesController < ApplicationController
  before_action :move_to_index 

  def new
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if params[:message][:image] != nil 
      if @message.save
        redirect_to new_order_room_message_path(@room.order_id, @room.id) and return
      else
        render :new and return
      end
    elsif params[:message][:content] == ''
      redirect_to new_order_room_message_path(@room.order_id, @room.id) and return
    else
      if @message.save
        date = @message.created_at.strftime("%Y/%m/%d %H:%M:%S")

        if @message.category == 'creator'
          profile = { 'first_name': @message.room.creator.first_name, 'last_name': @message.room.creator.last_name , 'date': date }
        else
          profile = { 'name': @message.room.company.name, 'date': date }
        end
        ActionCable.server.broadcast 'message_channel', content: @message, profile: profile
      else
        render :new and return
      end
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
