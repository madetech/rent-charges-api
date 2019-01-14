# frozen_string_literal: true

class RentDetailsGateway
  def all
    RentDetail201920.all
  end

  def save(rent_details)
    RentDetail201920.create(rent_details)
  end

  def find_by_year(year)
    RentDetail201920.find_by(year: year)
  end
end
