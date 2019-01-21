class UpdateRentCharges
  def initialize(fixed_data_gateway:, rent_charges_gateway:)
    @fixed_data_gateway = fixed_data_gateway
    @rent_charges_gateway = rent_charges_gateway
  end

  def execute(fixed_data)
    @fixed_data = fixed_data
    @rc_uplift = @fixed_data[:rc_uplift].to_f
    @year = @fixed_data[:year].to_i
    @fixed_data_gateway.save(@fixed_data)
    @rent_charges_gateway.save(rent_charges)

    { successful: true }
  end

  private

  def rent_charges
    rent_charges_for_given_year = @rent_charges_gateway.all(@year - 1)
    rent_charges_for_given_year.map do |rent_charge|
      { 
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
        year: rent_charge[:year] + 1,
        removed: rent_charge[:year],
        formula_rent_this_year: calc_formula_rent_this_year(rent_charge[:formula_rent_this_year]),
        rent_cap_this_year: calc_rent_cap_this_year(rent_charge[:rent_cap_this_year]),
        uprated_actual: calc_uprated_actual_rent(rent_charge[:uprated_actual])
      }
    end
  end

  def calc_rent_cap_this_year(rent_cap)
    @rent_cap = (rent_cap * ( 1 + @rc_uplift)).round(2) 
  end

  def calc_formula_rent_this_year(formula_rent)
    @formula_rent = (formula_rent * 0.99).round(2)
  end

  def calc_uprated_actual_rent(current_rent)
    @uprated_actual_rent = (current_rent * 0.99).round(2)
  end
end
