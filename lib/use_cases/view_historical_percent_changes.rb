class ViewHistoricalPercentChanges
  def initialize(rent_charge_gateway:, fixed_data_gateway:)
    @rent_charge_gateway = rent_charge_gateway
    @fixed_data_gateway = fixed_data_gateway
  end

  attr_reader :rent_charge_gateway,
              :fixed_data_gateway

  def execute
    counts.map do |item|
       { year: item[0], no_of_accounts: item[1], rc_uplift: fixed_data_gateway.rc_uplift(item[0]) }
    end
  end 

  def percent_changes_for_specific_year(year)
    return { error: :no_record_found } if no_of_accounts_count(year).zero?
    { year: year, no_of_accounts: no_of_accounts_count(year), rc_uplift: fixed_data_gateway.rc_uplift(year) }
  end 

  private

  def counts
    rent_charge_gateway.all.group_by { |i| i[:year] }.map do |key, value| 
      [key , value.count]
    end
  end 

  def no_of_accounts_count(year)
    rent_charge_gateway.all.count { |item| item[:year] == year.to_i }
  end 
end
