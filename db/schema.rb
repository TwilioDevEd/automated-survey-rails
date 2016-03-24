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

ActiveRecord::Schema.define(version: 20160324154252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id",             null: false
    t.integer  "source",      default: 0, null: false
    t.string   "content",                 null: false
    t.string   "from",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "answers", ["from"], name: "index_answers_on_from", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["source"], name: "index_answers_on_source", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "survey_id",              null: false
    t.string   "body",                   null: false
    t.integer  "type",       default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree
  add_index "questions", ["type"], name: "index_questions_on_type", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "surveys"
end
