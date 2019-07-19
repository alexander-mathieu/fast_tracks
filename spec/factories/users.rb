FactoryBot.define do
  factory :user do
    strava_uid { 1234 }
    strava_firstname { 'MyString' }
    strava_lastname { 'MyString' }
    strava_token { 'MyString' }
    spotify_uid { 'MyString' }
    spotify_token { 'MyString' }
  end
end
