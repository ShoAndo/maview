class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    if Outline.find_by(company_id: @company.id)
      @outline = Outline.find_by(company_id: @company.id)
    else
      return
    end

    if Card.find_by(company_id: @company.id)
      @card = Card.find_by(company_id: @company.id)
    else
      return
    end

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(company_id: @company.id)

    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end

  def edit
  end

  def update
  end
  
  private
  
  def company_params
  end

  
end
