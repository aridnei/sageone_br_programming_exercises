# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160630011950) do

  create_table "current_states", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.string   "barcode"
    t.string   "ncm"
    t.string   "unity"
    t.string   "supplier"
    t.string   "product_type"
    t.string   "brand"
    t.float    "weight",           default: 0.0
    t.string   "size"
    t.integer  "current_state_id", default: 0
    t.float    "stock",            default: 0.0
    t.float    "max_stock",        default: 0.0
    t.float    "min_stock",        default: 0.0
    t.float    "purchase_stock",   default: 0.0
    t.string   "composition"
    t.string   "raw_material"
    t.string   "office_supplies"
    t.string   "for_sale"
    t.string   "currency"
    t.string   "observations"
    t.float    "cost",             default: 0.0
    t.float    "sale_price",       default: 0.0
    t.float    "ipi",              default: 0.0
    t.string   "category"
    t.string   "unity_factor"
    t.string   "gender"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "products", ["code"], name: "index_products_on_code", unique: true

end
