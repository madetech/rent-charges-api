# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response

  def rent_detail_use_case_factory
    UseCaseFactory.new
  end
end
