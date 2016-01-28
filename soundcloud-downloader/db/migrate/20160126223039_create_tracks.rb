class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :artist_id, null: false
      t.string  :title, null: false
      t.integer :duration
      t.string  :artwork_url
      t.string  :stream_url, null:false

      t.timestamps null: false
    end
  end
end
