module Domain
  class FixedData
    attr_accessor :year,
                  :rc_uplift
  
     def initialize(**fixed_data)
      fixed_data.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end
end
