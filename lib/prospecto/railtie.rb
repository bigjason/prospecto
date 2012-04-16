require 'prospecto/controller'

module Prospecto
  class Railtie < Rails::Railtie
    initializer "prospecto.initialize" do |app|
      ActionController::Base.extend(ProspectoController)
    end
  end
end
