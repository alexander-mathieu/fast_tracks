class ChangePlayedAtToStringInUserSongs < ActiveRecord::Migration[5.2]
  def change
		change_column :user_songs, :played_at, :bigint
  end
end
