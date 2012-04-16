require 'prospecto/controller'

module Prospecto
  class Railtie < Rails::Railtie
    initializer "prospecto.initialize" do |app|
      ActionController::Base.extend(ProspectoController)
    end

    initializer 'prospecto.autoload', :before => :set_autoload_paths do |app|
      Dir["#{app.root}/app/views/**/"].each do |view_folder|
        app.config.autoload_paths << view_folder
      end
    end
  end
end
