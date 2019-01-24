class FixedDataGateway
  def save(fixed_data)
    Models::FixedDatum.create!(fixed_data)
    nil
  end

  def all
    Models::FixedDatum.all do |fixed_data|
      Domain::FixedData.new(
        year: fixed_data[:year],
        rc_uplift: fixed_data[:rc_uplift]
      )
    end
  end
  
  def rc_uplift(year)
    rc_uplift_by_year = all.find_by_year(year)
    rc_uplift_by_year[:rc_uplift] unless rc_uplift_by_year.nil?
  end
end 
