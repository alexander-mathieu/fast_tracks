FactoryBot.define do
  factory :user_song do
    user { nil }
    song { nil }
    play_count { 1 }
    power_ranking { 1.5 }
  end
end
