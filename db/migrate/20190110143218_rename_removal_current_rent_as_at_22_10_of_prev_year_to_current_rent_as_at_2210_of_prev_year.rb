class RenameRemovalCurrentRentAsAt2210OfPrevYearToCurrentRentAsAt2210OfPrevYear < ActiveRecord::Migration[5.2]
  def change
    rename_column :removals, :current_rent_as_at_22_10_of_prev_year, :current_rent_as_at_2210_of_prev_year
  end
end
