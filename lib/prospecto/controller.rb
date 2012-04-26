module Prospecto
  module ProspectoController
    extend ActiveSupport::Concern

    included do
      view_path = Rails.root.join("app/views")
      resolver = ActionView::FileSystemResolver.new(view_path, ":prefix/templates/:action{.:locale,}{.:formats,}{.:handlers,}")
      prepend_view_path(resolver)
    end
  end
end
