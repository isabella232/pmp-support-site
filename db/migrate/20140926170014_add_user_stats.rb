class AddUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.string  :user_guid
      t.timestamps

      # stats
      t.integer :story_count, default: 0
      t.integer :image_count, default: 0
      t.integer :audio_count, default: 0
      t.integer :video_count, default: 0
    end
  end
end
