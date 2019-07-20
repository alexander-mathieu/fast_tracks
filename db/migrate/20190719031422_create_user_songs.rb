class CreateUserSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_songs do |t|
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.integer :play_count
      t.float :power_ranking

      t.timestamps
    end
  end
end
