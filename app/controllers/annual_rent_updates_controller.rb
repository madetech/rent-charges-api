class AnnualRentUpdatesController < ApplicationController
  before_action :set_year, only: %i[show update destroy]
  
   # GET /annual-rent-updates
  def index
    response = use_case_factory.view_annual_rent_updates.execute
    json_response(response)
  end

  # GET /annual-rent-updates/:year
  def show
    response = use_case_factory.view_annual_rent_updates.specific_year(year: @year)
    json_response(response) 
  end

  private

  def set_year
   @year = params[:id]
  end
end

