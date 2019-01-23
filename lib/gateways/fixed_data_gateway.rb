class FixedDataGateway
  def save(fixed_data)
    FixedDatum.create!(fixed_data)
    nil
  end

  def all
    fixed_data = FixedDatum.all do |fixed_data|
      Domain::FixedData.new(
        year: fixed_data[:year],
        rc_uplift: fixed_data[:rc_uplift]
      )
    end
    fixed_data
  end
  
  def rc_uplift(year)
    rc_uplift_by_year = all.find_by_year(year)
    rc_uplift_by_year[:rc_uplift] unless rc_uplift_by_year.nil?
  end
end 