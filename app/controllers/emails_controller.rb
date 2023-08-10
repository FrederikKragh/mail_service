class EmailsController < ApplicationController
  Gmail = Google::Apis::GmailV1

  def new
    url = client.auth_code.authorize_url(
      redirect_uri: redirect_uri,
      scope: scope,
      state: SecureRandom.hex(16),
      client_id: client_id
    )

    redirect_to url, allow_other_host: true
  end

  def callback
    access_token = OAuth2::AccessToken.from_hash(client, get_token(params[:code]))

    # Instantiate service
    gmail.authorization = access_token.token

    # Save messages
    user_messages.messages.each do |msg|
      msg = gmail.get_user_message('me', msg.id, format:"full")
      Email.create(
        subject: msg.subject,
        from: msg.from
      )
    end

    email_id = user_messages.messages.first.id
    email = Mail.new(gmail.get_user_message('me', email_id).payload)

    render plain: email
  end

  private

  def gmail
    @gmail ||= Gmail::GmailService.new
  end

  def user_messages
    @user_messages ||= gmail.list_user_messages('me', max_results: 10)
  end

  def get_token(code)
    # contains "id_token", "access_token", "scope"
    client.auth_code.get_token(code, redirect_uri: redirect_uri, headers: {
      'Authorization' => "Basic #{basic_auth}",
    }).to_hash
  end

  def basic_auth
    Base64.urlsafe_encode64("#{client_id}:#{client_secret}")
  end

  def client_id
    ENV['GOOGLE_CLIENT_ID']
  end

  def client_secret
    ENV['GOOGLE_CLIENT_SECRET']
  end

  def site
    "https://gmail.googleapis.com"
  end

  def redirect_uri
    "http://localhost:3000/callback"
  end

  def authorize_url
    "https://accounts.google.com/o/oauth2/auth"
  end

  def token_url
    "https://oauth2.googleapis.com/token"
  end

  def scope
    [ 
      "https://www.googleapis.com/auth/gmail.addons.current.message.readonly",
      "https://www.googleapis.com/auth/gmail.readonly"
    ].join(' ')
  end

  def client
    @client ||= OAuth2::Client.new(client_id, client_secret, {
      authorize_url: authorize_url,
      token_url: token_url,
      site: site,
    })
  end
end
