# frozen_string_literal: true

class ViewFixedData
  def initialize(fixed_data_gateway:)
    @fixed_data_gateway = fixed_data_gateway
  end

  def execute
    @fixed_data_gateway.all
  end

  def specific_year(year)
    @fixed_data_gateway.find_by_year(year)
  end

  def rc_uplift(year)
    @fixed_data_gateway.rc_uplift(year)
  end
end
