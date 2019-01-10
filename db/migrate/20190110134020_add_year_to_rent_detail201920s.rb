class AddYearToRentDetail201920s < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_detail201920s, :year, :string
  end
end
