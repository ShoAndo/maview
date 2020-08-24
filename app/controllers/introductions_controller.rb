class IntroductionsController < ApplicationController
  before_action :find_creator, only: [:new, :create, :edit, :update]
  before_action :find_introduction, only: [:edit, :update]

  def new
    @introduction = Introduction.new
  end

  def create
    @introduction = Introduction.new(introduction_params)
    if @introduction.save
      redirect_to creator_path(@creator)
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @introduction.update(introduction_params)
      redirect_to creator_path(@creator)
    else
      render :edit
    end
  end

  private

  def find_creator
    @creator = Creator.find(params[:creator_id])
  end

  def find_introduction
    @introduction = Introduction.find(params[:id])
  end

  def introduction_params
    params.require(:introduction).permit(:pr_text, :price_per_hour).merge(creator_id: @creator.id)
  end

end
