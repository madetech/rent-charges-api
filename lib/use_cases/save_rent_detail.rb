class RentDetail
  def initialize(rent_detail_gateway:)
    @rent_detail_gateway = rent_detail_gateway
  end

  public

  def execute(rent_detail:)
    @rent_detail = rent_detail
    errors = validation
    
    return { successful: false, errors: errors } unless errors.empty?

    @rent_detail_gateway.save({ 
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
      year: rent_detail[:year]
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
    @rent_detail.each_key do |key|
      next if optional.include?(key)
      errors.push :"missing_#{key}" if @rent_detail[key].blank?
    end
    errors
  end
end 