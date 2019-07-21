# frozen_string_literal: true

FactoryBot.define do
  factory :user_song do
    user { nil }
    song { nil }
    sequence(:played_at) { |n| (1563723395108 + n + 50).to_s  }
    power_ranking { 0.5 }
  end
end
