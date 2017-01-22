class ApiController < ApplicationController
  # attr_reader :current_user

  # We do not need this because we use JWT for our api's authenticaton
  # Normally, Rails automatically ask the server for permission before sending
  # every POST request to secure cookies with XSS in mind.
  # http://apidock.com/rails/v4.2.1/ActionController/RequestForgeryProtection/verify_authenticity_token
  skip_before_action :verify_authenticity_token

  # Devise will know that we want to render json because we set default format
  # before running Devise authentication.
  before_action :set_default_format
  before_action :authenticate_user!

  private

    # Explicitly specify to Rails that we want to use json as a default format
    # rather than let Rails determine which format to use.
    def set_default_format
      # No matter what format is requested, we force to handle it as json.
      # If needed, we can write logic to determine how we handle other formats.
      request.format = :json
    end
end
