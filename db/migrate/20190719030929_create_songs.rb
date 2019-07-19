class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :spotify_id
      t.string :title
      t.string :artist
      t.string :album
      t.string :spotify_url
      t.string :album_art_url
      t.integer :length

      t.timestamps
    end
  end
end
