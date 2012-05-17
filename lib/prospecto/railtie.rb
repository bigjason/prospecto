require 'rails/railtie'

module Prospecto
  class Railtie < Rails::Railtie
    initializer "prospecto.initialize" do |app|
      # Import the url helpers to allow resolving of URLs easily
      Prospecto::PresenterView.send :include, Rails.application.routes.url_helpers
    end
  end
end
