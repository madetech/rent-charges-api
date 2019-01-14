class RentDetail
  def initialize(rent_detail_gateway:, fixed_data_gateway:)
    @rent_detail_gateway = rent_detail_gateway
    @fixed_data_gateway = fixed_data_gateway.get_rc_uplift
  end

  attr_reader :fixed_data_gateway, 
              :rent_detail_gateway,
              :rent_detail

  def execute(rent_detail:)
    @rent_detail = rent_detail
    errors = validation
    
    return { successful: false, errors: errors } unless errors.empty?

    rent_detail_gateway.save({ 
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
      formula_rent_prev_year: rent_detail[:formula_rent_prev_year],
      rent_cap_prev_year: rent_detail[:rent_cap_prev_year],
      current_rent_as_at_2407_of_prev_year: rent_detail[:current_rent_as_at_2407_of_prev_year],
      year: rent_detail[:year],
      formula_rent_this_year: calc_formula_rent_this_year,
      rent_cap_this_year: calc_rent_cap_this_year,
      lower_of_formula_rent_or_cap: calc_lower_of_formula_rent_or_cap,
      uprated_actual: calc_uprated_actual_rent,
      cap_v_act_plus_2_pounds: calc_cap_v_act_plus_2_pounds,
      act_minus_2_pounds: calc_act_minus_2_pounds,
      actual_rent_this_year: calc_uprated_actual_rent,
      converged: calc_converged,
      difference_between_ar_and_fr: calc_diff_ar_and_fr,
      full_year_forecast: calc_forecast,
      year_on_year_percentage_change: calc_year_on_year_percentage_change,
      actual_rent_greater_than_rent_cap: cal_actual_rent_greater_than_rc,
      actual_rent_greater_than_formula_rent: cal_actual_rent_greater_than_fr
    })

    return { successful: true, errors: [] }
  end 

  private

  def validation
    check_for_missing_fields
  end

  def check_for_missing_fields
    errors = []
    optional = %i[comments]
    rent_detail.each_key do |key|
      next if optional.include?(key)
      errors.push :"missing_#{key}" if rent_detail[key].blank?
    end
    errors
  end

  def calc_rent_cap_this_year
    (rent_detail[:rent_cap_prev_year] * ( 1 + fixed_data_gateway)).round(2) 
  end 

  def calc_lower_of_formula_rent_or_cap
    [calc_formula_rent_this_year, calc_rent_cap_this_year].min
  end 

  def calc_formula_rent_this_year
    (rent_detail[:formula_rent_prev_year] * 0.99).round(2)
  end 

  def calc_uprated_actual_rent
    (rent_detail[:current_rent_as_at_2407_of_prev_year] * 0.99).round(2)
  end

  def calc_cap_v_act_plus_2_pounds
    return calc_uprated_actual_rent + 2 if (calc_lower_of_formula_rent_or_cap - calc_uprated_actual_rent) > 2
    calc_lower_of_formula_rent_or_cap
  end 

  def calc_act_minus_2_pounds
    return calc_uprated_actual_rent - 2 if (calc_uprated_actual_rent - calc_cap_v_act_plus_2_pounds) > 2
    calc_cap_v_act_plus_2_pounds
  end 

  def calc_converged
    return 'Yes' if calc_uprated_actual_rent >= calc_formula_rent_this_year
    'No'
  end 

  def calc_diff_ar_and_fr
    (calc_formula_rent_this_year - calc_uprated_actual_rent).round(2)
  end 

  def calc_forecast
    actual_rent_this_year = rent_detail[:current_rent_as_at_2407_of_prev_year] * 0.99
    (actual_rent_this_year * 52).round(2)
  end 

  def calc_year_on_year_percentage_change
    diff_rents = calc_uprated_actual_rent - rent_detail[:current_rent_as_at_2407_of_prev_year]
    (diff_rents / rent_detail[:current_rent_as_at_2407_of_prev_year]).round(2) * 100
  end 

  def cal_actual_rent_greater_than_rc
    return 'Yes' if calc_uprated_actual_rent > calc_rent_cap_this_year
    'No'
  end 

  def cal_actual_rent_greater_than_fr
    return 'Yes' if calc_uprated_actual_rent > calc_formula_rent_this_year
    'No'
  end 
end 