class ContractPayment
  include ActiveModel::Model
  attr_accessor :price, :order_id, :creator_id, :company_id

  validates :price, presence: true 

  def save
    Payment.create(price: price, order_id: order_id)
    Contract.create(order_id: order_id, creator_id: creator_id, company_id: company_id)
  end
end