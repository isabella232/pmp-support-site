class UserStat < ActiveRecord::Base
  validates :user_guid, presence: true

  KNOWN_USERS = {
    apm: '98bf597a-2a6f-446c-9b7e-d8ae60122f0d',
    npr: '6140faf0-fb45-4a95-859a-070037fafa01',
    pbs: 'fc53c568-e939-4d9c-86ea-c2a2c70f1a99',
    pri: '7a865268-c9de-4b27-a3c1-983adad90921',
    prx: '609a539c-9177-4aa7-acde-c10b77a6a525',
  }

  def self.latest_known(user_key)
    if guid = KNOWN_USERS[user_key.to_sym]
      UserStat.where(user_guid: guid).order(created_at: :desc).first
    else
      nil
    end
  end

  def present?
    story_count > 0 || image_count > 0 || audio_count > 0 || video_count > 0
  end

  def blank?
    !present?
  end

end
