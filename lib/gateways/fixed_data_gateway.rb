class FixedDataGateway
  def save(fixed_data)
    FixedDatum.create!(fixed_data)
  end
end
