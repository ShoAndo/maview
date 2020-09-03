class CreatorRelationshipsController < ApplicationController
  before_action :find_company, :move_to_index

  def create
    following = current_creator.follow(@company)
    if following.save
      redirect_to company_path(@company)
    else
      redirect_to company_path(@company)
    end
  end

  def destroy
    following = current_creator.unfollow(@company)
    if following.destroy
      redirect_to company_path(@company)
    else
      redirect_to company_path(@company)
    end
  end

  private

  def find_company
    @company = Company.find(params[:company_id])
  end

  def move_to_index
    unless creator_signed_in?
      redirect_to root_path
    end
  end
end
