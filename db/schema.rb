# -*- encoding : utf-8 -*-
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101206064447) do

  create_table "branchconnections", :force => true do |t|
    t.integer  "brancher_id"
    t.integer  "branchee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", :force => true do |t|
    t.float    "scale"
    t.float    "y"
    t.float    "rotation"
    t.float    "length"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "ancestry_depth", :default => 0
  end

  add_index "branches", ["ancestry"], :name => "index_branches_on_ancestry"

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treedatas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.integer  "currentDepth"
  end

  create_table "tweets", :force => true do |t|
    t.string   "title"
    t.string   "screen_name"
    t.integer  "status_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "month",       :default => 0
    t.integer  "day",         :default => 0
  end

end