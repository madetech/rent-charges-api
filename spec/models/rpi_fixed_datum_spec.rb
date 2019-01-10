require 'rails_helper'

RSpec.describe RpiFixedDatum, type: :model do
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:rc_uplift) }
end
