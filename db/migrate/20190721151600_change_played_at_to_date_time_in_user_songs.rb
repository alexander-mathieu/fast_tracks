class ChangePlayedAtToDateTimeInUserSongs < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_songs, :played_at
		add_column :user_songs, :played_at, :datetime
  end
end
