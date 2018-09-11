require 'rails_helper'

RSpec.describe UserStat, type: :model do
  it { is_expected.to validate_presence_of :user_guid }

  describe '#present?' do
    context 'when story_count greater then 0' do
      it 'returns true' do
        user_stat = UserStat.new(story_count: 1, image_count: 0, audio_count: 0, video_count: 0)

        expect(user_stat.present?).to be true
      end
    end

    context 'when image_count greater then 0' do
      it 'returns true' do
        user_stat = UserStat.new(story_count: 0, image_count: 1, audio_count: 0, video_count: 0)

        expect(user_stat.present?).to be true
      end
    end

    context 'when audio_count greater then 0' do
      it 'returns true' do
        user_stat = UserStat.new(story_count: 0, image_count: 0, audio_count: 1, video_count: 0)

        expect(user_stat.present?).to be true
      end
    end

    context 'when video_count greater then 0' do
      it 'returns true' do
        user_stat = UserStat.new(story_count: 0, image_count: 0, audio_count: 0, video_count: 1)

        expect(user_stat.present?).to be true
      end
    end

    context 'when video_count, story_count, image_count, audio_count are 0' do
      it 'returns false' do
        user_stat = UserStat.new(story_count: 0, image_count: 0, audio_count: 0, video_count: 0)

        expect(user_stat.present?).to be false
      end
    end
  end

  describe '#blank?' do
    context 'when story_count greater then 0' do
      it 'returns false' do
        user_stat = UserStat.new(story_count: 1, image_count: 0, audio_count: 0, video_count: 0)

        expect(user_stat.blank?).to be false
      end
    end

    context 'when image_count greater then 0' do
      it 'returns false' do
        user_stat = UserStat.new(story_count: 0, image_count: 1, audio_count: 0, video_count: 0)

        expect(user_stat.blank?).to be false
      end
    end

    context 'when audio_count greater then 0' do
      it 'returns false' do
        user_stat = UserStat.new(story_count: 0, image_count: 0, audio_count: 1, video_count: 0)

        expect(user_stat.blank?).to be false
      end
    end

    context 'when video_count greater then 0' do
      it 'returns false' do
        user_stat = UserStat.new(story_count: 0, image_count: 0, audio_count: 0, video_count: 1)

        expect(user_stat.blank?).to be false
      end
    end

    context 'when video_count, story_count, image_count, audio_count are 0' do
      it 'returns true' do
        user_stat = UserStat.new(story_count: 0, image_count: 0, audio_count: 0, video_count: 0)

        expect(user_stat.blank?).to be true
      end
    end
  end

  describe '.latest_known' do
    context 'when the passed user_key belongs to a know user' do
      it 'returns the latest created user with the passed user_key' do
        UserStat.create(user_guid: UserStat::KNOWN_USERS[:apm])
        last_user_stat = UserStat.create(user_guid: UserStat::KNOWN_USERS[:apm])

        expect(UserStat.latest_known(:apm)).to eq last_user_stat
      end
    end

    context 'when the passed user_key does not belongs to a know user' do
      it 'returns nil' do
        UserStat.create(user_guid: UserStat::KNOWN_USERS[:apm])
        UserStat.create(user_guid: UserStat::KNOWN_USERS[:apm])

        expect(UserStat.latest_known('user_key')).to be nil
      end
    end
  end
end
