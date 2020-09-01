class OrdersController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
    if params[:job_category_id]
      @orders = Order.includes(:company).where(job_category_id: params[:job_category_id]).where.not(id: Contract.select('order_id')).order('created_at DESC').limit(10)
      @job_category = JobCategory.find(params[:job_category_id]).name
    else
      @orders = Order.includes(:company).where.not(id: Contract.select('order_id')).order('created_at DESC').limit(10)
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @orders = Order.search(params[:keyword])
  end

  private

  def move_to_index
    unless company_signed_in?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order).permit(:title, :content, :last_day, :deadline, :award, :job_category_id).merge(company_id: current_company.id)
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
