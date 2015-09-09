require 'jwt'
module AuthToken
  def AuthToken.issue_token(payload, exp=30.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base, verify=true)
    rescue
      false
    end
  end
end
