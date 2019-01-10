# frozen_string_literal: true

class CreateCpiFixedData < ActiveRecord::Migration[5.2]
  def change
    create_table :cpi_fixed_data do |t|
      t.string :year
      t.decimal :cpi
      t.decimal :real
      t.decimal :fr_uplift
      t.decimal :rc_factor
      t.decimal :rc_uplift

      t.timestamps
    end
  end
end
