class RentChargeStatisticsController < ApplicationController
  before_action :set_year, only: %i[show update destroy]

  # GET /rent-charge-statistics/:year
  def show
    rent_charge_statistics = use_case_factory.view_rent_charge_statistics.execute(year: @year)
    json_response(rent_charge_statistics)
  end

  private

  def set_year
    @year = params[:id]
  end
end
