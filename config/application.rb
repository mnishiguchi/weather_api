require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeatherApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # http://guides.rubyonrails.org/generators.html
    config.generators do |g|
      g.test_framework  nil
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end
  end
end
