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

ActiveRecord::Schema.define(version: 20170517000944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.date "date"
    t.string "notes"
  end

  create_table "calendars_notes", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "interview_id"
  end

  create_table "calendars_openings", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "opening_id"
  end

  create_table "calendars_organizations", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "organization_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.string "linkedin"
    t.string "context"
    t.string "notes"
  end

  create_table "contacts_notes", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "interview_id"
  end

  create_table "contacts_openings", force: :cascade do |t|
    t.integer "contact_id"
    t.integer "opening_id"
  end

  create_table "contacts_organizations", force: :cascade do |t|
    t.integer "contact_id"
    t.integer "organization_id"
  end

  create_table "contacts_tags", force: :cascade do |t|
    t.integer "contact_id"
    t.integer "tag_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.string "location"
    t.integer "opening_id"
    t.integer "calendar_id"
  end

  create_table "interviews_notes", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "interview_id"
  end

  create_table "my_links", force: :cascade do |t|
    t.string "text"
    t.string "url"
  end

  create_table "notes", force: :cascade do |t|
    t.string "notes"
  end

  create_table "notes_openings", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "interview_id"
  end

  create_table "notes_organizations", force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "interview_id"
  end

  create_table "openings", force: :cascade do |t|
    t.string "name"
    t.string "salary"
    t.string "desc"
    t.string "link"
    t.integer "organization_id"
    t.string "notes"
    t.string "cover_letter"
    t.string "location"
  end

  create_table "openings_tags", force: :cascade do |t|
    t.integer "opening_id"
    t.integer "tag_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.string "headquarters"
    t.string "link"
  end

  create_table "organizations_tags", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

end
