require 'rails_helper'

RSpec.describe RecentStory, type: :model do
  it { is_expected.to validate_presence_of :story_guid }
  it { is_expected.to validate_uniqueness_of :story_guid }
  it { is_expected.to validate_presence_of :creator_name }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :published_date }
  it { is_expected.to validate_presence_of :image_url }
end
