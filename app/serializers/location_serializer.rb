class LocationSerializer < ActiveModel::Serializer
  # Specify attributes we want to add to JSON.
  attributes :id, :name, :current

  # AMS can understand Rails model relationships.
  has_many :recordings

  # We can define API specific custom attributes here. That will prevent the model
  # file from bloating.

  def current
    {
      temp: 13,
      status: "rainy"
    }
  end
end
