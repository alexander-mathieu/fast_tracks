class SongSyncJob < ApplicationJob
  queue_as :default

	def perform(current_user)
		spotify_service = SpotifyService.new(current_user.spotify_token)
    songs_data = spotify_service.get_user_songs[:items]
    SongSifter.new(songs_data, current_user).sift_songs
	end
end
