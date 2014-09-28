class AddRecentStories < ActiveRecord::Migration
  def change
    create_table :recent_stories do |t|
      t.string  :story_guid
      t.timestamps

      # crunched pmp data
      t.text   :title
      t.string :permalink
      t.string :image_url
      t.string :creator_name
      t.string :show_name
      t.date   :published_date
    end
  end
end
