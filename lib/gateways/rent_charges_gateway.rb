class RentChargesGateway
  def save(rent_charges)
    rent_charges.each do |rent_charge|
      Models::RentCharge.create!(rent_charge)
    end
  end

  def all(year)
    Models::RentCharge.where(year: year).map do |rent_charge|
      Domain::RentCharge.new(
        uprn: rent_charge[:uprn],
        address: rent_charge[:address],
        address_2: rent_charge[:address_2],
        comments: rent_charge[:comments],
        rr_count: rent_charge[:rr_count],
        property_type: rent_charge[:property_type],
        base_data_bed_size: rent_charge[:base_data_bed_size],
        bedroom_weight: rent_charge[:bedroom_weight],
        mra_archetype: rent_charge[:mra_archetype],
        jan_1999_asset_values: rent_charge[:jan_1999_asset_values],
        year: rent_charge[:year],
        removed: rent_charge[:removed],
        formula_rent_this_year: rent_charge[:formula_rent_this_year],
        rent_cap_this_year: rent_charge[:rent_cap_this_year],
        uprated_actual: rent_charge[:uprated_actual]
      )
    end
  end
end
