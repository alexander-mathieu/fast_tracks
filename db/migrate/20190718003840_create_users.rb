class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :strava_uid
      t.string :strava_name
      t.string :strava_token
      t.integer :spotify_uid
      t.string :spotify_token
    end
  end
end
