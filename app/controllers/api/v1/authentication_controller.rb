class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!

  # http://localhost:3000/api/v1/auth
  def ceate
    user = User.find_by(email: params[:id][:email])
    if user.valid_password? params[:user][:password]
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password"]}
    end
  end
end
