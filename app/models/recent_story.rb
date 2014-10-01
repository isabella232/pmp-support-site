class RecentStory < ActiveRecord::Base
  validates :story_guid,     presence: true, uniqueness: true
  validates :creator_name,   presence: true
  validates :title,          presence: true
  validates :published_date, presence: true
  validates :image_url,      presence: true

  # attempt to get a diverse sampling of recent stories
  def self.rich_sample(limit = 10)
    oversample = RecentStory.order('published_date DESC, id DESC').limit(limit * 2).to_a
    rich = []

    # sample from known users first
    UserStat::KNOWN_USERS.each do |key, guid|
      if idx = oversample.find_index { |rs| rs.creator_name == key.to_s }
        rich << oversample.delete_at(idx)
      end
    end

    # bring up to limit, and re-sort
    rich.concat oversample.slice(0, limit - rich.count)
    rich.sort { |a, b| b.published_date <=> a.published_date }
  end

end
