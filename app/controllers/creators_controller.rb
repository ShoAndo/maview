class CreatorsController < ApplicationController

  def show
    @creator = Creator.find(params[:id])
  end
end
