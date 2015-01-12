class RecentStory < ActiveRecord::Base
  validates :story_guid,     presence: true, uniqueness: true
  validates :creator_name,   presence: true
  validates :title,          presence: true
  validates :published_date, presence: true
  validates :image_url,      presence: true

  # attempt to get a diverse sampling of recent stories
  def self.rich_sample(limit = 10)
    rich = []
    sorter = 'published_date DESC, id DESC'

    # first, get a sample from each user
    UserStat::KNOWN_USERS.each do |key, guid|
      top = RecentStory.where(creator_name: key.to_s).order(sorter)
      rich.concat top.limit(limit / UserStat::KNOWN_USERS.count)
    end

    # fill in
    if rich.count < limit
      ids = rich.map { |r| r.id }
      more = RecentStory.where('id not in (?)', ids).order(sorter)
      rich.concat more.limit(limit - rich.count)
    end

    # HACK: get a smaller thumbnail for NPR images
    rich.each do |r|
      if r.creator_name == 'npr' && r.image_url && r.image_url.match(/media\.npr\.org/)
        r.image_url.gsub!(/\.jpg$/, '-s400-c85.jpg')
      end
    end

    # re-sort
    rich.sort_by { |rs| [rs.published_date, rs.id] }.reverse
  end

end
