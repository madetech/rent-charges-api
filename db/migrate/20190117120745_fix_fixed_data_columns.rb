class FixFixedDataColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :fixed_data, :real
    remove_column :fixed_data, :rc_factor
    remove_column :fixed_data, :fr_uplift
    remove_column :fixed_data, :cpi
  end
end
