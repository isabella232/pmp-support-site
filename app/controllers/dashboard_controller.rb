class DashboardController < ApplicationController

  # GET /
  def index
    @partners = UserStat::KNOWN_USERS.map do |key, guid|
      {
        name: key.upcase,
        image: "partners/#{key}_square.jpg",
        stats: recent_stats(key),
      }
    end
    @recents = RecentStory.rich_sample(24)
    @total = @partners.map { |p| p[:stats].values.inject(:+) }.inject(:+)
  end

protected

  # find recent stats, or return 0's
  def recent_stats(user_key)
    if stat = UserStat.latest_known(user_key)
      {
        story_count: stat.story_count,
        image_count: stat.image_count,
        audio_count: stat.audio_count,
        video_count: stat.video_count,
      }
    else
      {
        story_count: 0,
        image_count: 0,
        audio_count: 0,
        video_count: 0,
      }
    end
  end

end
