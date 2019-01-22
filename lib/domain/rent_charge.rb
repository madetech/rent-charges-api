module Domain
  class RentCharge
    attr_accessor :uprn,
                  :address,
                  :address_2,
                  :comments,
                  :rr_count,
                  :property_type,
                  :base_data_bed_size,
                  :bedroom_weight,
                  :mra_archetype,
                  :jan_1999_asset_values,
                  :year,
                  :removed,
                  :formula_rent_this_year,
                  :rent_cap_this_year,
                  :uprated_actual
    
    def initialize(**rent_charges)
      rent_charges.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end
end
