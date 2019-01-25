class AnnualRentUpdatesController < ApplicationController
  before_action :set_year, only: %i[show]
  
   # GET /annual-rent-updates
  def index
    annual_rent_updates = use_case_factory.view_annual_rent_updates.execute
    json_response(annual_rent_updates)
  end

  # GET /annual-rent-updates/:year
  def show
    annual_rent_updates = use_case_factory.view_annual_rent_updates.specific_year(year: @year)
    json_response(annual_rent_updates) 
  end

  private

  def set_year
   @year = params[:id] 
  end
end

