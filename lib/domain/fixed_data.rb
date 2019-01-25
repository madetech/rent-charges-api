module Domain
  class FixedData
    include ActiveModel::Model
    attr_accessor :year,
                  :rc_uplift
  end
end
