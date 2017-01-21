# https://github.com/jwt/ruby-jwt
class JsonWebToken

  # Takes in a hash and returns a base64-encoded text.
  def self.encode(payload)
    expiration = 10.minutes.from_now.to_i
    JWT.encode(payload.merge(exp: expiration), Rails.application.secrets.secret_key_base)
  end

  # Takes in a token and returns its payload.
  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  end
end

# We can test the encode/decode methods in a console.
#
#   $ rails c
#   >> JsonWebToken.encode({"sub" => "1"})
#   => "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIn0.AiWAfZUjDM39odfDLvq0lHig37R4KTI-a_Tk33g8Tcs"
#   >> JsonWebToken.decode "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIn0.AiWAfZUjDM39odfDLvq0lHig37R4KTI-a_Tk33g8Tcs"
#   => {"sub"=>"1"}
