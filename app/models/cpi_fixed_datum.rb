# frozen_string_literal: true

class CpiFixedDatum < ApplicationRecord
  validates_presence_of :year
  validates_presence_of :rc_uplift
end
