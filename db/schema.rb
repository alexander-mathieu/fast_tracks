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

ActiveRecord::Schema.define(version: 2019_07_21_151600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "strava_id"
    t.bigint "user_id"
    t.string "name"
    t.float "distance"
    t.float "moving_time"
    t.float "elapsed_time"
    t.float "total_elevation_gain"
    t.string "activity_type"
    t.datetime "start_date"
    t.datetime "start_date_local"
    t.string "start_latlng"
    t.string "end_latlng"
    t.float "average_speed"
    t.float "max_speed"
    t.integer "pr_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "spotify_id"
    t.string "title"
    t.string "artist"
    t.string "album"
    t.string "spotify_url"
    t.string "album_art_url"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_songs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "song_id"
    t.float "power_ranking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "played_at"
    t.index ["song_id"], name: "index_user_songs_on_song_id"
    t.index ["user_id"], name: "index_user_songs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "strava_uid"
    t.string "strava_firstname"
    t.string "strava_lastname"
    t.string "strava_token"
    t.string "spotify_uid"
    t.string "spotify_token"
  end

  add_foreign_key "activities", "users"
  add_foreign_key "user_songs", "songs"
  add_foreign_key "user_songs", "users"
end
