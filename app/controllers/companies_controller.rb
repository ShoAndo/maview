class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    if Outline.find_by(company_id: @company.id)
      @outline = Outline.find_by(company_id: @company.id)
    else
      return
    end
  end

  def edit
  end

  def update
  end
  
  private
  
  def company_params
  end

  
end
