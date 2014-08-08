require 'active_support/concern'
require 'rest_client'

module GoogleAnalytics
  extend ActiveSupport::Concern

  def ga_event!(category, action)
    if Rails.application.secrets.ga_key.present? && params[:ga_client_id].present?
      args = {
        v:   1,
        t:   'event',
        tid: Rails.application.secrets.ga_key,
        cid: params[:ga_client_id],
        ec:  category,
        ea:  action,
      }
      begin
        RestClient.get('http://www.google-analytics.com/collect', params: args, timeout: 4, open_timeout: 4)
        return true
      rescue  RestClient::Exception => rex
        return false
      end
    else
      false
    end
  end

end
