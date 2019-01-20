class UpdateRentDetails
  def initialize(fixed_data_gateway:, rent_detail_gateway:)
    @fixed_data_gateway = fixed_data_gateway
    @rent_detail_gateway = rent_detail_gateway
  end

  def execute(fixed_data)
    @fixed_data = fixed_data
    @rc_uplift = @fixed_data[:rc_uplift].to_f
    @year = @fixed_data[:year].to_i
    @fixed_data_gateway.save(@fixed_data)
    @rent_detail_gateway.save(rent_details)

    { successful: true }
  end

  private

  def rent_details
    rent_details_for_given_year = @rent_detail_gateway.all(@year - 1)
    rent_details_for_given_year.map do |rent_detail|
      { 
        uprn: rent_detail[:uprn],
        address: rent_detail[:address],
        address_2: rent_detail[:address_2],
        comments: rent_detail[:comments],
        rr_count: rent_detail[:rr_count],
        property_type: rent_detail[:property_type],
        base_data_bed_size: rent_detail[:base_data_bed_size],
        bedroom_weight: rent_detail[:bedroom_weight],
        mra_archetype: rent_detail[:mra_archetype],
        jan_1999_asset_values: rent_detail[:jan_1999_asset_values],
        year: rent_detail[:year] + 1,
        formula_rent_this_year: calc_formula_rent_this_year(rent_detail[:formula_rent_this_year]),
        rent_cap_this_year: calc_rent_cap_this_year(rent_detail[:rent_cap_this_year]),
        uprated_actual: calc_uprated_actual_rent(rent_detail[:uprated_actual])
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
