# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_21_102609) do

  create_table "fixed_data", force: :cascade do |t|
    t.integer "year"
    t.decimal "rc_uplift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rent_charges", force: :cascade do |t|
    t.string "uprn"
    t.string "address"
    t.string "address_2"
    t.string "comments"
    t.decimal "rr_count"
    t.integer "property_type"
    t.integer "base_data_bed_size"
    t.decimal "bedroom_weight"
    t.string "mra_archetype"
    t.decimal "jan_1999_asset_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.boolean "removed"
    t.decimal "formula_rent_this_year"
    t.decimal "rent_cap_this_year"
    t.decimal "uprated_actual"
  end

  create_table "rent_summaries", force: :cascade do |t|
    t.string "year"
    t.decimal "rr_count_total"
    t.decimal "jan_1999_asset_values_total"
    t.decimal "formula_rent_prev_year_average"
    t.decimal "rent_cap_prev_year_average"
    t.decimal "current_rent_as_at_2407_of_prev_year_average"
    t.decimal "formula_rent_this_year_average"
    t.decimal "rent_cap_this_year_average"
    t.decimal "lower_of_formula_rent_or_cap_average"
    t.decimal "uprated_actual_average"
    t.decimal "actual_rent_this_year_average"
    t.decimal "ratio_of_actual_rent_this_year_to_current_rent_at_2407_of_prev_year"
    t.decimal "ar_average_fr_average_difference"
    t.decimal "full_year_forecast_average"
    t.decimal "year_on_year_percentage_change_average"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
