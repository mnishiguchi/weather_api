class ApiController < ApplicationController
  # attr_reader :current_user

  # We do not need this because we use JWT for our api's authenticaton
  # Normally, Rails automatically ask the server for permission before sending
  # every POST request to secure cookies with XSS in mind.
  # http://apidock.com/rails/v4.2.1/ActionController/RequestForgeryProtection/verify_authenticity_token
  skip_before_action :verify_authenticity_token

  before_action :set_default_format
  before_action :authenticate_token!

  private

    # Explicitly specify to Rails that we want to use json as a default format
    # rather than let Rails determine which format to use.
    def set_default_format
      # No matter what format is requested, we force to handle it as json.
      # If needed, we can write logic to determine how we handle other formats.
      request.format = :json
    end

    def authenticate_token!
      payload = JsonWebToken.decode(auth_token)
      @current_user = User.find(payload["sub"])

      p @current_user

    # Define descriptive error messages for each error type.
    # https://github.com/jwt/ruby-jwt/blob/master/lib/jwt/error.rb
    rescue JWT::ExpiredSignature
      render json: {errors: ["Auth token has expired"]}, status: :unauthrized
    rescue JWT::DecodeError
      render json: {errors: ["invalid token"]}, status: :unauthrized
    end

    # Extracts a token from a request header if any.
    def auth_token
      @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
    end
end
