class CreateRpiFixedData < ActiveRecord::Migration[5.2]
  def change
    create_table :rpi_fixed_data do |t|
      t.string :year
      t.decimal :rpi
      t.decimal :real
      t.decimal :fr_uplift
      t.decimal :rc_factor
      t.decimal :rc_uplift

      t.timestamps
    end
  end
end
