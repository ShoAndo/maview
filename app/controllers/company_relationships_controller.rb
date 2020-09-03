class CompanyRelationshipsController < ApplicationController
  before_action :find_creator, :move_to_index

  def create
    following = current_company.follow(@creator)
    if following.save
      redirect_to creator_path(@creator)
    else
      redirect_to creator_path(@creator)
    end
  end

  def destroy
    following = current_company.unfollow(@creator)
    if following.destroy
      redirect_to creator_path(@creator)
    else
      redirect_to creator_path(@creator)
    end
  end

  private

  def find_creator
    @creator = Creator.find(params[:creator_id])
  end

  def move_to_index
    unless company_signed_in?
      redirect_to root_path
    end
  end
end
