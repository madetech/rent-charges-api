class FixedDataGateway
  def save(fixed_data)
    Models::FixedDatum.create!(fixed_data)
    nil
  end
end
