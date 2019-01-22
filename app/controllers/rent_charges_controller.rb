# frozen_string_literal: true

class RentChargesController < ApplicationController
  # POST /rent-charges
  def create
    fixed_data = {
      year: fixed_datum_params[:year],
      rc_uplift: fixed_datum_params[:rc_uplift]
    }

    response = use_case_factory.update_rent_charges.execute(fixed_data)
    return json_response(response) unless response[:successful] == true
    json_response(fixed_data, :created)
  end

  private

  def fixed_datum_params
    params.permit(:rc_uplift, :year)
  end
end
