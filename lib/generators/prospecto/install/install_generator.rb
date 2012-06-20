module Prospecto
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def write_application_presenter
      template 'application_presenter.rb', "app/presenters/application_presenter.rb"
    end

    def write_application_presenter_spec
      template 'application_presenter_spec.rb', "spec/presenters/application_presenter_spec.rb"
    end
  end
end
