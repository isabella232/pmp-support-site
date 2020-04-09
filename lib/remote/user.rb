#
# a remote pmp user
#
class Remote::User

  # client label for support app
  SUPPORT_CLIENT_LABEL = 'pmp-support-app'

  # buffer before requesting a new oauth token
  TOKEN_BUFFER_SECONDS = 600

  # required: env and either user/pass or id/secret
  attr_reader :env
  attr_reader :username
  attr_reader :password
  attr_reader :client_id
  attr_reader :client_secret
  attr_reader :token
  attr_reader :token_expires

  # constructor
  def initialize(opts = {})
    opts = opts.with_indifferent_access
    @env           = opts[:env] || 'production'
    @username      = opts[:username]
    @password      = opts[:password]
    @client_id     = opts[:client_id]
    @client_secret = opts[:client_secret]
    @token         = opts[:token]
    @token_expires = opts[:token_expires]

    # make sure we have credentials
    ensure_support_client!

    # make sure we have a token (retry once, in case pmp is lagging)
    begin
      ensure_support_token!
    rescue OAuth2::Error => e
      sleep 1
      ensure_support_token!
    end
  end

  # get host url as defined by secrets.yml
  def host
    Rails.application.secrets.pmp_hosts.with_indifferent_access[@env].try(:[], 'host') || 'unknown'
  end

  # unique key per user+host
  def key
    "#{@username}@#{self.host.gsub(/^https?:\/\/|\/$/, '')}"
  end

  # get a user/pass client
  def auth_client
    PMP::Client.new(endpoint: host, user: @username, password: @password)
  end

  # get an oauth client
  def pmp_client
    if @token
      PMP::Client.new(endpoint: host, oauth_token: @token)
    else
      PMP::Client.new(endpoint: host, client_id: @client_id, client_secret: @client_secret)
    end
  end

  # hashify
  def as_json
    {
      env:           @env,
      username:      @username,
      password:      @password,
      client_id:     @client_id,
      client_secret: @client_secret,
      token:         @token,
      token_expires: @token_expires,
      host:          host,
      key:           key,
    }
  end

protected

  # find or create a client for the support app
  def ensure_support_client!
    if @client_id.blank? || @client_secret.blank?
      pmp = self.auth_client
      all_clients = pmp.credentials.list.clients

      # find or create a client for the support-app to use
      client = all_clients.find { |c| c['label'] == SUPPORT_CLIENT_LABEL }
      unless client
        client = pmp.credentials.create(scope: 'write', label: SUPPORT_CLIENT_LABEL)
      end
      @client_id = client[:client_id]
      @client_secret = client[:client_secret]
    end
  end

  # memoize token and expiration
  def ensure_support_token!
    if @token.blank? || @token_expires.blank? || Time.now.to_i >= @token_expires
      @token = nil
      token_resp = self.pmp_client.token
      @token = token_resp.token
      @token_expires = Time.now.to_i + token_resp.params['token_expires_in'] - TOKEN_BUFFER_SECONDS
    end
  end

end
