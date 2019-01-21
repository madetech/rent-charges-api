class ChangeFixedDataYearColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :fixed_data, :year, :integer
  end
end
