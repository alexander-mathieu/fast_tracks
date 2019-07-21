class RemovePlayCountFromUserSongs < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_songs, :play_count, :integer
  end
end
