class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    if Outline.find_by(company_id: @company.id)
      @outline = Outline.find_by(company_id: @company.id)
    end

    if Card.find_by(company_id: @company.id)
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(company_id: @company.id)

      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
    @contracts = Contract.includes(:creator).includes(:order).where(company_id: @company.id)
    @following = CompanyRelationship.where(company_id: @company.id)
    @follower = CreatorRelationship.where(follow_id: @company.id)
  end

  def edit
  end

  def update
  end
  
  private
  
  def company_params
  end

  
end
