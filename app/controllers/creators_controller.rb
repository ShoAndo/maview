class CreatorsController < ApplicationController

  def show
    @creator = Creator.find(params[:id])
    if Career.find_by(creator_id: @creator.id)
      @career = Career.find_by(creator_id: @creator.id)
    else
      return
    end
    if Portforio.find_by(creator_id: @creator.id)
      @portforio = Portforio.find_by(creator_id: @creator.id)
    else
      return
    end
    if Skill.find_by(creator_id: @creator.id)
      @skill = Skill.find_by(creator_id: @creator.id)
    else
      return
    end
    if Introduction.find_by(creator_id: @creator.id)
      @introduction = Introduction.find_by(creator_id: @creator.id)
    end
  end

  def edit
  end

  def update
  end

  private

  def creator_params
  end
end
