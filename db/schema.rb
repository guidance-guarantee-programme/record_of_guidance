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

ActiveRecord::Schema.define(version: 20170710142023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointment_summaries", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_appointment"
    t.money "value_of_pension_pots", scale: 2
    t.string "guider_name"
    t.integer "user_id"
    t.string "reference_number"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "address_line_3"
    t.string "town"
    t.string "county"
    t.string "postcode"
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "format_preference"
    t.string "has_defined_contribution_pension"
    t.money "upper_value_of_pension_pots", scale: 2
    t.boolean "value_of_pension_pots_is_approximate"
    t.string "country", default: "United Kingdom"
    t.boolean "supplementary_benefits"
    t.boolean "supplementary_debt"
    t.boolean "supplementary_ill_health"
    t.boolean "supplementary_defined_benefit_pensions"
    t.string "appointment_type"
    t.boolean "requested_digital", default: true, null: false
    t.integer "number_of_previous_appointments", default: 0, null: false
    t.integer "count_of_pension_pots"
    t.string "email", default: ""
    t.string "notification_id", default: ""
    t.boolean "supplementary_pension_transfers", default: false
    t.datetime "notify_completed_at"
    t.integer "notify_status", default: 0, null: false
    t.boolean "telephone_appointment", default: true
    t.string "covering_letter_type", default: "", null: false
    t.index ["user_id"], name: "index_appointment_summaries_on_user_id"
  end

  create_table "appointment_summaries_batches", id: :serial, force: :cascade do |t|
    t.integer "appointment_summary_id"
    t.integer "batch_id"
    t.index ["appointment_summary_id"], name: "index_appointment_summaries_batches_on_appointment_summary_id"
    t.index ["batch_id"], name: "index_appointment_summaries_batches_on_batch_id"
  end

  create_table "batches", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "uploaded_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "organisation"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.integer "invitations_count", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "role", default: "", null: false
    t.string "name", default: ""
    t.string "uid", default: "", null: false
    t.string "organisation_slug", default: ""
    t.string "organisation_content_id", default: ""
    t.string "permissions"
    t.boolean "remotely_signed_out", default: false
    t.boolean "disabled", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "appointment_summaries_batches", "appointment_summaries"
  add_foreign_key "appointment_summaries_batches", "batches"
end
