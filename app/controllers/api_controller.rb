class ApiController < ApplicationController
  before_action :set_default_format

  private

    # Explicitly specify to Rails that we want to use json as a default format
    # rather than let Rails determine which format to use.
    def set_default_format
      # No matter what format is requested, we force to handle it as json.
      # If needed, we can write logic to determine how we handle other formats.
      request.format = :json
    end
end
