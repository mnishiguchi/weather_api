# Generated by the knock gem. https://github.com/nsarno/knock
class Api::V1::UserTokenController < Knock::AuthTokenController
  # We need to explicitly specify the model name because the controller is namespaced.
  def entity_name
    "User"
  end
end