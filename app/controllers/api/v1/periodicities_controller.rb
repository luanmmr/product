class Api::V1::PeriodicitiesController < Api::V1::ApiController
  def index
    render json: Periodicity.all
  end
end
