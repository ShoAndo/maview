class CareersController < ApplicationController

  def new
    @career = Career.new
    @creator = Creator.find(params[:creator_id])
  end

  def create
    @career = Career.new(career_params)
    if @career.save
      redirect_to creator_path(current_creator)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def career_params
    params.require(:career).permit(:job_category_id, :year).merge(creator_id: current_creator.id)
  end
end
