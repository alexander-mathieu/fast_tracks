FactoryBot.define do
  factory :activity do
    name { "MyString" }
    distance { 1.5 }
    moving_time { 1.5 }
    elapsed_time { 1.5 }
    total_elevation_gain { 1.5 }
    activity_type { "" }
    strava_id { 1 }
    start_date { "2019-07-20 14:58:28" }
    start_date_local { "2019-07-20 14:58:28" }
    start_latlng { "MyString" }
    end_latlng { "MyString" }
    average_speed { 1.5 }
    max_speed { 1.5 }
    pr_count { 1 }
  end
end
