# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FixedDatum, type: :model do
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:rc_uplift) }
end
