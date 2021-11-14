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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2021_11_10_200149) do
=======
ActiveRecord::Schema.define(version: 2021_10_15_155527) do
>>>>>>> c584c567a8607d9b8a7f088def5189aaff8967dc

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "deposits", force: :cascade do |t|
    t.integer "deposit_id"
    t.integer "officer_uin"
<<<<<<< HEAD
=======
    t.string "category"
>>>>>>> c584c567a8607d9b8a7f088def5189aaff8967dc
    t.float "amount"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "member_uin"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.date "join_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "officers", force: :cascade do |t|
    t.integer "officer_uin"
    t.string "name"
    t.string "email"
    t.float "amount_owed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

<<<<<<< HEAD
  create_table "payment_methods", force: :cascade do |t|
    t.string "method"
=======
  create_table "payments", force: :cascade do |t|
    t.integer "payment_id"
    t.string "payment_mtd"
    t.date "date"
    t.string "membership_type"
    t.date "membership_expiration"
    t.float "amount"
    t.integer "member_uin"
    t.integer "officer_uin"
>>>>>>> c584c567a8607d9b8a7f088def5189aaff8967dc
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

<<<<<<< HEAD
  create_table "payments", force: :cascade do |t|
    t.integer "payment_id"
    t.string "method"
    t.date "date"
    t.string "membership_type"
    t.date "membership_expiration"
    t.float "amount"
    t.integer "member_uin"
    t.integer "officer_uin"
=======
  create_table "transaction_types", force: :cascade do |t|
    t.integer "transaction_id"
    t.string "category"
>>>>>>> c584c567a8607d9b8a7f088def5189aaff8967dc
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "withdrawals", force: :cascade do |t|
    t.integer "withdraw_id"
    t.integer "officer_uin"
<<<<<<< HEAD
=======
    t.string "category"
>>>>>>> c584c567a8607d9b8a7f088def5189aaff8967dc
    t.float "amount"
    t.string "title"
    t.string "description"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
