class Api::V1::LocationsController < ApiController
  before_action :set_location

  # http://localhost:3000/api/v1/locations/1.json
  def show
    # This will trigger the active_model_serializers to kick in.
    # If we do not explicitly call the render method, .jbuilder template will be rendered.
    # For nested resources, we need to explicitly state which resources we want to
    # include. By default, only id and type will be rendered.
    # https://github.com/rails-api/active_model_serializers/issues/968#issuecomment-116876424
    render json: @location, include: ["recordings"]
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end
end
