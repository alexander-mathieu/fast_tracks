# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SongSyncJob, type: :job do
  it "will sync a user's songs" do
    VCR.use_cassette('song_sync_job') do
      token = 'BQBN3pCzyhCqLxyZiIRalIvA2aN9gN9sQiPZhrl6CHa-uzErubDT7s57coRkhazXSOJuOZirZI72sN_8KsLl_TX1-9ybaZfmTqkcfOTEVOt7KHbLD9FCHczgyx2jyW6YOIwumSIlYMXSHT1XJQGuc3PV-CSl_KfHkkAhCjnpTwYATuqNmo5V-4I'
      user = create(:user, spotify_token: token)

      SongSyncJob.perform_now(user)
      user.reload
      expect(user.user_songs.count).to eq(50)
    end
  end
end
