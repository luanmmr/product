class PricesController < ApplicationController
  before_action :prices_all, only: %i[index create]
  before_action :plans_all, only: %i[index create edit update]
  before_action :periodicities_all, only: %i[index create edit update]

  def index
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    return redirect_to prices_path, notice: t('.success') if @price.save

    flash.now[:alert] = t('.error')
    render :index
  end

  def edit
    @price = Price.find(params[:id])
  end

  def update
    @price = Price.find(params[:id])
    return redirect_to prices_path, notice: t('.success') \
           if @price.update(price_params)

    flash.now[:alert] = t('.error')
    render :edit
  end

  def destroy
    Price.destroy(params[:id])
    redirect_back fallback_location: prices_path
  end

  private

  def prices_all
    @prices = Price.all
  end

  def plans_all
    @plans = Plan.all
  end

  def periodicities_all
    @periodicities = Periodicity.all
  end

  def price_params
    params.require(:price).permit(:plan_price, :plan_id, :periodicity_id)
  end
end
