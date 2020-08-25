class PaymentsController < ApplicationController
  before_action :move_to_index
  before_action :find_order, :find_room

  def index
    @contract_payment = ContractPayment.new
  end

  def create
    @contract_payment = ContractPayment.new(payment_params)

    if current_company.card.present?

      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer_token = current_company.card.customer_token
      Payjp::Charge.create(
        amount: @order.award,
        customer: customer_token,
        currency: 'jpy' 
        )

      if @contract_payment.valid?
        @contract_payment.save
        return redirect_to root_path
      else
        render :index
      end

    else

      if @contract_payment.valid?
        pay_item
        @contract_payment.save
        return redirect_to root_path
      else
        render :index
      end

    end
  end

  private

  def payment_params
    params.permit().merge(price: @order.award, order_id: @order.id, creator_id: @room.creator_id, company_id: @room.company_id)
  end

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_room
    @room = Room.find(params[:room_id])
  end

  def move_to_index
    unless company_signed_in?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: payment_params[:price],
      card: params[:token],
      currency:'jpy'
    )
  end
end
