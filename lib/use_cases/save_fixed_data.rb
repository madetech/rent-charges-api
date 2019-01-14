# frozen_string_literal: true

class SaveFixedData
  def initialize(fixed_data_gateway:)
    @fixed_data_gateway = fixed_data_gateway
  end

  def execute(fixed_data)
    errors = validation(fixed_data)

    return { successful: false, errors: errors } unless errors.empty?

    @fixed_data_gateway.save(
      year: fixed_data[:year],
      cpi: fixed_data[:cpi],
      real: fixed_data[:real],
      fr_uplift: fixed_data[:fr_uplift],
      rc_factor: fixed_data[:rc_factor],
      rc_uplift: rc_uplift_default(fixed_data)
    )

    { successful: true, errors: [] }
  end

  private

  def validation(fixed_data)
    errors = []
    errors.push(:null_year) if fixed_data[:year].blank?
    errors
  end

  def rc_uplift_default(fixed_data)
    return -0.01 if fixed_data[:rc_uplift].blank?

    fixed_data[:rc_uplift]
  end
end
