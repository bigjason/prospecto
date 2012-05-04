module Prospecto
  class PresenterView
    def initialize(args={})
      args.each do |name, value|
        if respond_to? name
          instance_variable_set("@#{name}", value)
        else
          # Stop everything there is a design problem.
          raise ArgumentError.new("Unknown property '#{name}' for class '#{self.class.name}'.")
        end
      end
    end

    class << self
      # "Presents" means a member will be reflected out to the view
      alias :presents :attr_reader

      # Accepts means the view uses the member internally, but it is not available
      # outside the class.
      def accepts(*args)
        args.each do |name|
          define_method name do
            instance_variable_get("@#{name}")
          end
          protected name
        end
      end
    end
  end
end
