class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :strava_uid
      t.string :strava_firstname
      t.string :strava_lastname
      t.string :strava_token
      t.string :spotify_uid
      t.string :spotify_token
    end
  end
end
