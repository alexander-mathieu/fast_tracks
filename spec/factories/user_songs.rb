# frozen_string_literal: true

FactoryBot.define do
  factory :user_song do
    user { nil }
    song { nil }
    sequence(:played_at) { |n| (DateTime.now + n.minutes) }
    power_ranking { 0.5 }
  end
end
