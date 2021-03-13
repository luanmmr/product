class PlansController < ApplicationController
  before_action :plan_all, only: %i[index create]
  before_action :products_all, only: %i[index create edit update]

  def index
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    return redirect_to plans_path, notice: t('.success') \
           if @plan.save

    flash.now[:alert] = t('.error')
    render :index
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    return redirect_to plans_path, notice: t('.success') \
           if @plan.update(plan_params)

    flash.now[:alert] = t('.error')
    render :edit
  end

  def destroy
    Plan.destroy(params[:id])
    redirect_back fallback_location: plans_path
  end

  def deactivate
    Plan.find(params[:id]).disabled!
    redirect_back fallback_location: plans_path
  end

  def activate
    Plan.find(params[:id]).activated!
    redirect_back fallback_location: plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :description, :product_type_id,
                                 :details, :status)
  end

  def plan_all
    @plans = Plan.all
  end

  def products_all
    @products = ProductType.all
  end
end
