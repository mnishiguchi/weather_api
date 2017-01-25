class RecordingSerializer < ActiveModel::Serializer
  # Specify attributes we want to add to JSON.
  attributes :id, :temp, :status

  # AMS can understand Rails model relationships.
  belongs_to :location

  # We can define API specific custom attributes here. That will prevent the model
  # file from bloating.
end
