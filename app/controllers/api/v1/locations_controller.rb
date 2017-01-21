class Api::V1::LocationsController < ApplicationController
  before_action :set_location

  # http://localhost:3000/api/v1/locations/1.json
  def show
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end
end
