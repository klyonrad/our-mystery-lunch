# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_17_202433) do

  create_table "employees", force: :cascade do |t|
    t.string "nick_name"
    t.string "department"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lunch_participations", force: :cascade do |t|
    t.integer "lunch_id", null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_lunch_participations_on_employee_id"
    t.index ["lunch_id"], name: "index_lunch_participations_on_lunch_id"
  end

  create_table "lunches", force: :cascade do |t|
    t.datetime "consumed_after"
  end

  add_foreign_key "lunch_participations", "employees"
  add_foreign_key "lunch_participations", "lunches"
end
