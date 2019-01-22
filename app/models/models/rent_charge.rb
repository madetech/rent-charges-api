module Models  
  class RentCharge < ApplicationRecord
    
    enum property_type: [:Bungalow, :Flat, :Hostel, :House, :Maisonette]

    validates_presence_of :uprn
    validates_presence_of :address
    validates_presence_of :address_2
    validates_presence_of :rr_count
    validates_presence_of :property_type
    validates_presence_of :base_data_bed_size
    validates_presence_of :bedroom_weight
    validates_presence_of :mra_archetype
    validates_presence_of :jan_1999_asset_values
    validates_presence_of :formula_rent_this_year
    validates_presence_of :rent_cap_this_year
    validates_presence_of :uprated_actual
    validates_presence_of :year
    validates_presence_of :removed
  end
end
