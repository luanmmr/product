class PeriodicitiesController < ApplicationController
  before_action :periodicity_all, only: %i[index create]

  def index
    @periodicity = Periodicity.new
  end

  def create
    @periodicity = Periodicity.new(periodicity_params)
    return redirect_to periodicities_path, notice: t('.success') \
           if @periodicity.save

    flash.now[:alert] = t('.error')
    render :index
  end

  def edit
    @periodicity = Periodicity.find(params[:id])
  end

  def update
    @periodicity = Periodicity.find(params[:id])
    return redirect_to periodicities_path, notice: t('.success') \
           if @periodicity.update(periodicity_params)

    flash.now[:alert] = t('.error')
    render :edit
  end

  def destroy
    Periodicity.destroy(params[:id])
    redirect_back fallback_location: periodicities_path,
                  notice: t('.success')
  end

  private

  def periodicity_all
    @periodicities = Periodicity.all
  end

  def periodicity_params
    params.require(:periodicity).permit(:name, :period)
  end
end
