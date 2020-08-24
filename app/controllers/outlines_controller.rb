class OutlinesController < ApplicationController
  before_action :find_company, only: [:new, :create, :edit, :update]
  before_action :find_outline, only: [:edit, :update]

  def new
    @outline = Outline.new
  end

  def create
    @outline = Outline.new(outline_params)
    if @outline.save
      redirect_to company_path(@company.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @outline.update(outline_params)
      redirect_to company_path(@company.id)
    else
      render :edit
    end
  end

  private

  def outline_params
    params.require(:outline).permit(:outline).merge(company_id: @company.id)
  end

  def find_company
    @company = Company.find(params[:company_id])
  end

  def find_outline
    @outline = Outline.find(params[:id])
  end
end
