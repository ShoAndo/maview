class CareersController < ApplicationController
  before_action :find_creator, only: [:new, :create, :edit, :update]
  before_action :find_career, only: [:edit, :update]

  def new
    @career = Career.new
  end

  def create
    @career = Career.new(career_params)
    if @career.save
      redirect_to creator_path(@creator.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @career.update(career_params)
      redirect_to creator_path(@creator.id)
    else
      render :edit
    end
  end

  private

  def find_creator
    @creator = Creator.find(params[:creator_id])
  end

  def find_career
    @career = Career.find(params[:id])
  end

  def career_params
    params.require(:career).permit(:job_category_id, :year).merge(creator_id: current_creator.id)
  end
end
