require 'jwt'
module AuthToken
  def AuthToken.issue_token(payload)
    # hmac_secret = ENV["JWT_SECRET"]
    # p hmac_secret
    # set expiration to 30 days.
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def AuthToken.valid?(token)
    # check token validity
    # hmac_secret = ENV["JWT_SECRET"]
    # p hmac_secret
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end
