module Prospecto
  module ProspectoController
    def enable_prospecto
      view_path = Rails.root.join("app/views")
      resolver = ActionView::FileSystemResolver.new(view_path, ":prefix/templates/:action{.:locale,}{.:formats,}{.:handlers,}")
      prepend_view_path(resolver)
    end
  end
end
