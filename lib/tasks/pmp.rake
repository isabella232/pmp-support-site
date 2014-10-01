#
# pmp background tasks
#
namespace :pmp do

  # helper to get us some pmp
  def get_pmp_client(admin = false)
    remote_usr = nil
    %w(production sandbox).each do |env|
      cfg = Rails.application.secrets.pmp_hosts[env]
      pfx = admin ? 'client' : 'public'
      if cfg["#{pfx}_id"].present? && cfg["#{pfx}_secret"].present?
        remote_usr = Remote::User.new(env: env, client_id: cfg["#{pfx}_id"], client_secret: cfg["#{pfx}_secret"])
        break
      end
    end

    # validate
    if Rails.env.production? && remote_usr.env != 'production'
      raise "Woh there - no PMP #{admin ? 'admin' : 'public'} credentials set for production environment!"
    elsif !remote_usr
      raise "Woh there - no PMP #{admin ? 'admin' : 'public'} credentials set for any environment!"
    end
    remote_usr.pmp_client
  end

  desc 'write pmp production stats to the database'
  task :stats => :environment do
    prof_stats = {story_count: 'story', image_count: 'image', audio_count: 'audio', video_count: 'video'}
    pmp = get_pmp_client(false)

    # get a list of all user guids
    created = 0
    UserStat::KNOWN_USERS.each do |key, guid|
      stat = UserStat.new(user_guid: guid)
      prof_stats.each do |method, type|
        res = pmp.query['urn:collectiondoc:query:docs'].where(creator: guid, profile: type, limit: 1)
        if res && res.navigation && res.navigation[:self]
          stat[method] = res.navigation[:self].totalitems
        end
      end

      # only save if non-blank
      if stat.present?
        stat.save!
        created += 1
      end
    end
    Rails.logger.info("pmp:stats finished - #{created} records created")
  end

  desc 'write recent pmp production stories to the database'
  task :recent => :environment do
    pmp = get_pmp_client(true)
    query = pmp.query['urn:collectiondoc:query:docs']

    # attempt to get a couple from each known user
    created = 0
    UserStat::KNOWN_USERS.each do |key, guid|
      res = query.where(creator: guid, profile: 'story', has: 'image', searchsort: 'date', limit: 2)
      res.items.each do |item|
        next if RecentStory.where(story_guid: item.guid).first

        # new story
        story = RecentStory.new(story_guid: item.guid)
        story.creator_name = key
        story.title = item.title
        story.published_date = item.published

        #  look real hard for an image
        img_item = item.items.find { |i| i.profile.first.url.match(/image$/) }
        crops = Hash[img_item.enclosure.map { |encl|
          crop_type = (encl[:meta] && encl[:meta][:crop]) ? encl[:meta][:crop] : 'unknown'
          [crop_type, encl.url]
        }]
        story.image_url = crops.values.first
        %w(small thumb standard primary).each do |type|
          if crops[type].present?
            story.image_url = crops[type]
            break
          end
        end

        # optional permalink
        if item.alternate && item.alternate.first
          story.permalink = item.alternate.first.url
        end

        # optional series name
        if item.collection
          belongs_to = item.collection.find { |l| l[:rels].include?('urn:collectiondoc:collection:series') } ||
                       item.collection.find { |l| l[:rels].include?('urn:collectiondoc:collection:property') } ||
                       item.collection.find { |l| l[:rels].include?('urn:collectiondoc:collection:contributor') }
          if belongs_to
            story.show_name = belongs_to.title
          end
        end

        # save, logging any validation errors
        if story.save
          created += 1
        else
          Rails.logger.error("pmp:recent ERROR - unable to import story: #{Rails.story.errors.full_messages.join('; ')}")
          Rails.logger.error(story.attributes.to_yaml)
        end
      end
    end
    Rails.logger.info("pmp:recent finished - #{created} records created")
  end

end
