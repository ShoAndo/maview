class PortforiosController < ApplicationController
  before_action :find_creator, only: [:new, :create, :edit, :update]
  before_action :find_portforio, only: [:edit, :update]
  def new
    @portforio = Portforio.new
  end

  def create
    @portforio = Portforio.new(portforio_params)
    if @portforio.save
      redirect_to creator_path(@creator.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @portforio.update(portforio_params)
      redirect_to creator_path(@creator.id)
    else
      render :edit
    end
  end

  private

  def find_creator
    @creator = Creator.find(params[:creator_id])
  end

  def find_portforio
    @portforio = Portforio.find(params[:id])
  end

  def portforio_params
    params.require(:portforio).permit(:outline, :url, :detail, :github).merge(creator_id: @creator.id)
  end
end
