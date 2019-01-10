class RenameRentDetail201920CurrentRentAsAt2407OfPrevYearToCurrentRentAsAt2407OfPrevYear < ActiveRecord::Migration[5.2]
  def change
    rename_column :rent_detail201920s, :current_rent_as_at_24_07_of_prev_year, :current_rent_as_at_2407_of_prev_year
  end
end
