class ProxyController < ApplicationController
  before_filter :require_login!, only: :current_pmp

  include PMP::Connection

  # GET /proxy/public/...
  def public_proxy

  end

  # GET /proxy/current/...
  def current_user_proxy
    binding.pry
    # raw = connection()

    # begin
    #   raw = connection(current_options.merge({url: url})).send(method) do |request|
    #     if [:post, :put].include?(method.to_sym) && !body.blank?
    #       request.body = PMP::CollectionDocument.to_persist_json(body)
    #     end
    #   end
    # rescue Faraday::Error::ResourceNotFound=>not_found_ex
    #   if (method.to_sym == :get)
    #     raw = OpenStruct.new(body: nil, status: 404)
    #   else
    #     raise not_found_ex
    #   end
    # end

    # conn = Faraday.new(:url => 'http://sushi.com') do |faraday|
    #   faraday.request  :url_encoded             # form-encode POST params
    #   faraday.response :logger                  # log requests to STDOUT
    #   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    # end

    token = current_pmp.current_options[:oauth_token]

  end

end
