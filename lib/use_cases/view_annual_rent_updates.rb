class ViewAnnualRentUpdates
  def initialize(rent_charges_gateway:, fixed_data_gateway:)
    @rent_charges_gateway = rent_charges_gateway
    @fixed_data_gateway = fixed_data_gateway
  end

  attr_reader :rent_charges_gateway,
              :fixed_data_gateway,
              :year

  def execute
    counts.map do |item|
       { year: item[:year], no_of_accounts: item[:count], rc_uplift: fixed_data_gateway.rc_uplift(item[:year]) }
    end
  end 

  def specific_year(year: year)
    @year = year
    errors = validations
    return { successful: false, errors: errors } unless errors.empty?
    { year: year, no_of_accounts: no_of_accounts_count, rc_uplift: fixed_data_gateway.rc_uplift(year) }
  end 

  private

  def counts
    rent_charges_gateway.all_rent_charges.group_by { |i| i[:year] }.map do |key, value| 
      {year: key , count: value.count}
    end
  end 

  def no_of_accounts_count
    rent_charges_gateway.all_rent_charges.count { |item| item[:year] == year.to_i }
  end 

  def validations
    errors = []
    errors.push(:missing_year) if year.nil?
    errors.push(:invalid_year) unless valid_year?
    errors.push(:no_record_found) if no_of_accounts_count.zero?
    errors
  end

   def valid_year?
    year.to_s.match(/[0-9]{4}/)
  end
end
