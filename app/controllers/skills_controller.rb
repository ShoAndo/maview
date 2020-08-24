class SkillsController < ApplicationController
  before_action :find_creator, only: [:new, :create, :edit, :update]
  before_action :find_skill, only: [:edit, :update]

  def new
    @skill = Skill.new
  end

  def create
    binding.pry
    @skill = Skill.new(skill_params)

    if @skill.save
      redirect_to creator_path(@creator.id)
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @skill.update(skill_params)
      redirect_to creator_path(@creator.id)
    else
      render :edit
    end
  end

  private

  def find_creator
    @creator = Creator.find(params[:creator_id])
  end

  def find_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:skill_name, :level_id, :year ).merge(creator_id: @creator.id)
  end

end
