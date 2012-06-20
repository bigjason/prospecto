module Prospecto
  class PresenterGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def write_presenter
      template 'presenter.rb', "app/presenters/#{file_name_root}_presenter.rb"
    end

    def write_presenter_spec
      template 'presenter_spec.rb', "spec/presenters/#{file_name_root}_presenter_spec.rb"
    end

    protected

    def file_name_root
      name.underscore
    end

    def class_name
      name.camelize
    end

    def single_name
      name.underscore.singularize
    end

    def base_class
      if File.exists?(Rails.root.join("app/presenters/application_presenter.rb"))
        "ApplicationPresenter"
      else
        "Prospecto::PresenterView"
      end
    end
  end
end
