class FixedDataGateway
  def find_by_year(year)
    FixedDatum.find_by(year: year)
  end

   def rc_uplift(year)
    find_by_year(year)[:rc_uplift] if find_by_year(year)
  end
end 