require "set"

module Prospecto
  class PresenterView
    def initialize(args={})
      args.each do |name, value|
        if respond_to? name
          instance_variable_set("@#{name}", value)
        elsif self.class.__delegates.include?(name)
          __delegates << value
        else
          # Stop everything there is a design problem.
          raise ArgumentError.new("Unknown property '#{name}' for class '#{self.class.name}'.")
        end
      end
    end

    def method_missing(name, *args, &block)
      if property_name = self.class.__properties.find{|m| name.to_s.start_with? "#{m}_"}
        field_name = name.to_s.sub("#{property_name}_", "")
        self.send(property_name).send(field_name)
      elsif delegate_obj = __delegates.find{|d| d.respond_to? name}
        delegate_obj.send(name)
      else
        super
      end
    end

    def __delegates
      @__delegates ||= Set.new
    end

    class << self
      # "Presents" means a member will be reflected out to the view. Use of presents should be
      # limited to very special cases.
      alias :presents :attr_reader

      def __properties
        @__properties ||= Set.new
      end

      def __delegates
        @__delegates ||= Set.new
      end

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

      # Proxies means that the properties of the object can be accessed directly from this object
      # when prefixed with the object name. (ie: @view.user_full_name)
      def proxies(*args)
        args.each do |name|
          __properties << name
        end
        accepts(*args)
      end

      # Decorates means that properties of the object will be available directly on the presenter.
      def decorates(*args)
        args.each do |name|
          __delegates << name
        end
      end
    end
  end
end
