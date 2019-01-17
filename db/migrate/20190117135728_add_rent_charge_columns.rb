class AddRentChargeColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_charges, :year, :string
    add_column :rent_charges, :removed, :boolean
  end
end
