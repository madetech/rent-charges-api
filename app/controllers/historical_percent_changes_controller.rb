class HistoricalPercentChangesController < ApplicationController
  before_action :set_fixed_datum, only: %i[show update destroy]

  def initialize
   rent_charge_gateway = RentChargeGateway.new
   fixed_data_gateway = FixedDataGateway.new
   @view_historical_percent_changes = ViewHistoricalPercentChanges.new(
    rent_charge_gateway: rent_charge_gateway, fixed_data_gateway: fixed_data_gateway)
  end
  
   # GET /historical-percent-change
  def index
    response = @view_historical_percent_changes.execute
    json_response(response)
  end

  # GET /historical-percent-change/:year
  def show
    response = @view_historical_percent_changes.percent_changes_for_specific_year(@year)
    return json_response(response) unless response[:error] == :no_record_found
  end

  private

  def set_fixed_datum
   @year = params[:id]
  end
end

