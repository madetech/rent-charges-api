class AnnualRentUpdatesController < ApplicationController
  before_action :set_year, only: %i[show update destroy]

  def initialize
   rent_charge_gateway = RentChargeGateway.new
   fixed_data_gateway = FixedDataGateway.new
   @view_annual_rent_updates = ViewAnnualRentUpdates.new(
    rent_charge_gateway: rent_charge_gateway, fixed_data_gateway: fixed_data_gateway)
  end
  
   # GET /annual-rent-updates
  def index
    response = @view_annual_rent_updates.execute
    json_response(response)
  end

  # GET /annual-rent-updates/:year
  def show
    response = @view_annual_rent_updates.percent_changes_for_specific_year(@year)
    return json_response(response) unless response[:error] == :no_record_found
  end

  private

  def set_year
   @year = params[:id]
  end
end

