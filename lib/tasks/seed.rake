#
# seed some demo data into the database
#
namespace :seed do

  SEED_STAMP = '2001-01-01 01:01:01'
  FAKE_TITLES = [
    'When the digital classroom meets the parents',
    'After the NIH funding comes the "hangover"',
    'What is Biohacking and why should we care?',
    'India is over the moon about its mission to Mars',
    'All together now: The Beatles are back in mono',
    'Farm to table movement needs more structure'
  ]
  FAKE_IMAGES = %w(
    http://lorempixel.com/640/480/abstract
    http://lorempixel.com/900/300/city
    http://lorempixel.com/1200/800/people
    http://lorempixel.com/600/400/animals
    http://lorempixel.com/600/400/business
    http://lorempixel.com/600/400/cats
    http://lorempixel.com/600/400/sports
    http://lorempixel.com/600/400/transport
  )
  FAKE_SHOWS = ['Marketplace', 'PBS NewsHour', 'Splendid Table', 'PRI\'s The World', 'The Moth', 'All Things Considered']

  desc 'fake some demo data instead of loading it from the pmp'
  task :demo => :environment do
    random = Random.new

    # fake stats
    UserStat::KNOWN_USERS.each do |key, guid|
      us = UserStat.new
      us.created_at  = SEED_STAMP
      us.user_guid   = guid
      us.story_count = random.rand(40000)
      us.image_count = random.rand(9000)
      us.audio_count = random.rand(9000)
      us.video_count = random.rand(9000)
      us.save!
    end

    # fake stories
    12.times do |i|
      rs = RecentStory.new
      rs.created_at     = SEED_STAMP
      rs.story_guid     = SecureRandom.uuid
      rs.title          = FAKE_TITLES.sample
      rs.image_url      = FAKE_IMAGES.sample
      rs.creator_name   = UserStat::KNOWN_USERS.keys.sample
      rs.published_date = rand(100).days.ago(Date.today)
      if [true, false].sample
        rs.permalink = 'http://google.com'
      end
      if [true, false].sample
        rs.show_name = FAKE_SHOWS.sample
      end
      rs.save
    end
  end

  desc 'cleanup any seeded data'
  task :clean => :environment do
    stats = UserStat.where(created_at: DateTime.parse(SEED_STAMP))
    stories = RecentStory.where(created_at: DateTime.parse(SEED_STAMP))

    puts "...destroying #{stats.count} user_stats..."
    stats.destroy_all

    puts "...destroying #{stories.count} recent_stories..."
    stories.destroy_all
  end

end
