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

  # GET /stats
  def stats
    @stats = Rails.cache.fetch('dashboard_stats', expires_in: 10.minutes) do
      stats = {all: {}}
      UserStat::KNOWN_USERS.map do |key, guid|
        recent = recent_stats(key)
        stats[key] = {
          total: recent.values.inject(:+),
          story: recent[:story_count],
          image: recent[:image_count],
          audio: recent[:audio_count],
          video: recent[:video_count],
        }
      end

      # for now, just set "all" to be the sum of the partners
      stats[:all][:total] = stats.values.map { |s| s[:total] || 0 }.inject(&:+)
      stats[:all][:story] = stats.values.map { |s| s[:story] || 0 }.inject(&:+)
      stats[:all][:image] = stats.values.map { |s| s[:image] || 0 }.inject(&:+)
      stats[:all][:audio] = stats.values.map { |s| s[:audio] || 0 }.inject(&:+)
      stats[:all][:video] = stats.values.map { |s| s[:video] || 0 }.inject(&:+)
      stats
    end
    render json: @stats
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
