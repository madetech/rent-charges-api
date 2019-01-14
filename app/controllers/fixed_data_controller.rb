# frozen_string_literal: true

class FixedDataController < ApplicationController
  before_action :set_fixed_datum, only: %i[show update destroy]

  def initialize
    @gateway = FixedDataGateway.new
    @save_fixed_data = SaveFixedData.new(fixed_data_gateway: @gateway)
    @view_fixed_data = ViewFixedData.new(fixed_data_gateway: @gateway)
  end

  # GET /fixed-data
  def index
    data = @view_fixed_data.execute
    json_response(data)
  end

  # GET /fixed-data/:year
  def show
    data = @view_fixed_data.specific_year(@year)
    json_response(data)
  end

  # POST /fixed-data
  def create
    fixed_data = {
      year: fixed_datum_params['year'],
      cpi: fixed_datum_params['cpi'],
      real: fixed_datum_params['real'],
      fr_uplift: fixed_datum_params['fr_uplift'],
      rc_factor: fixed_datum_params['fr_factor'],
      rc_uplift: fixed_datum_params['rc_uplift']
    }
    @save_fixed_data.execute(fixed_data)
    json_response(fixed_datum_params, :created)
  end

  private

  def fixed_datum_params
    params.permit(:year, :cpi, :real, :fr_uplift, :rc_factor, :rc_uplift)
  end

  def set_fixed_datum
    @year = params[:id]
  end
end
