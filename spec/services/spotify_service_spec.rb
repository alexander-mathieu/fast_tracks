# frozen_string_literal: true

require 'rails_helper'

describe SpotifyService do
  it 'finds all user songs' do
    VCR.use_cassette('spotify_get_songs') do
      token = 'BQCz-BjV_MmJxnBYMQLXKj_O5WA8qkFihpptmzLqiVQDTs62Vrmq9FpcARgWZivZA5NqmRf63RIVtbCjJ_IzNIZIT7ajHukWLiBvo-kMIVZ2WF66jyV4Ku9RHhus1pef-l7q3Yd3A7_Me6r_cl89TDOo0g'
      service = SpotifyService.new(token)

      song_data = service.get_user_songs
      songs = song_data[:items]

      expect(songs.first[:track][:name]).to eq('No Diablo')
    end
  end
end
