class FixedDataGateway
  def save(fixed_data)
    FixedDatum.create(fixed_data)
  end

  def all
    FixedDatum.all
  end
end
