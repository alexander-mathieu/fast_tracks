class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.bigint :strava_id
      t.references :user, foreign_key: true
      t.string :name
      t.float :distance
      t.float :moving_time
      t.float :elapsed_time
      t.float :total_elevation_gain
      t.string :activity_type
      t.datetime :start_date
      t.datetime :start_date_local
      t.string :start_latlng
      t.string :end_latlng
      t.float :average_speed
      t.float :max_speed
      t.integer :pr_count

      t.timestamps
    end
  end
end
