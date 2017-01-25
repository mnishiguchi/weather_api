class Api::V1::LocationsController < ApiController
  skip_before_action :authenticate_user! # FIXME: Temporarily deactivate authentication

  before_action :set_location

  # http://localhost:3000/api/v1/locations/1.json
  def show
    # This will trigger the active_model_serializers to kick in.
    # If we do not explicitly call the render method, .jbuilder template will be rendered.
    render json: @location
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end
end
