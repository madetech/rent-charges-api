# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response

  def rent_charges_use_case_factory
    UseCaseFactory.new
  end
end
