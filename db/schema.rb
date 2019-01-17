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

ActiveRecord::Schema.define(version: 2019_01_17_115112) do

  create_table "fixed_data", force: :cascade do |t|
    t.string "year"
    t.decimal "cpi"
    t.decimal "real"
    t.decimal "fr_uplift"
    t.decimal "rc_factor"
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
    t.string "property_type"
    t.decimal "base_data_bed_size"
    t.decimal "bedroom_weight"
    t.string "mra_archetype"
    t.decimal "jan_1999_asset_values"
    t.decimal "formula_rent_prev_year"
    t.decimal "rent_cap_prev_year"
    t.decimal "current_rent_as_at_2407_of_prev_year"
    t.decimal "formula_rent_this_year"
    t.decimal "rent_cap_this_year"
    t.decimal "lower_of_formula_rent_or_cap"
    t.decimal "uprated_actual"
    t.decimal "cap_v_act_plus_2_pounds"
    t.decimal "act_minus_2_pounds"
    t.decimal "actual_rent_this_year"
    t.string "converged"
    t.decimal "difference_between_ar_and_fr"
    t.decimal "full_year_forecast"
    t.decimal "year_on_year_percentage_change"
    t.string "actual_rent_greater_than_rent_cap"
    t.string "actual_rent_greater_than_formula_rent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "year"
  end

end
