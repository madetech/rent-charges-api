# frozen_string_literal: true

class FixedDataGateway
  def save(fixed_data)
    CpiFixedDatum.create(fixed_data)
  end

  def all
    CpiFixedDatum.all
  end

  def find_by_year(year)
    CpiFixedDatum.find_by(year: year)
  end

  def rc_uplift(year)
    find_by_year(year)[:rc_uplift]
  end
end
