require "set"

module Prospecto
  # Optional base class for convenience when working with rails presenters.
  class PresenterView
    # Initialize a new PresenterView instance accepting the provided arguments.
    #
    # @param [Hash] args key value pairs for what ever properties you declared
    #                    on the class.
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

    # @private
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

    # @private
    def __delegates
      @__delegates ||= Set.new
    end

    class << self
      # Instructs the class to create a publicly visible version of the value.
      #
      # @param [Symbols*] args name of the properties to accept.  This will be used in the constructor.
      def presents(*args)
        attr_reader(*args)
      end

      # Instructs the class to *accept* the value internally but not
      # publish it.
      #
      # @param [Symbols*] args name of the properties to accept.  This will be used in the constructor.
      def accepts(*args)
        args.each do |name|
          define_method name do
            instance_variable_get("@#{name}")
          end
          protected name
        end
      end

      # Instructs the class that the properties of the object can be accessed directly from this object
      # when prefixed with the object name. (ie: `@view.user_full_name`)
      #
      # @param [Symbols*] args name of the properties to accept.  This will be used in the constructor.
      def proxies(*args)
        args.each do |name|
          __properties << name
        end
        accepts(*args)
      end

      # Instructs the class to proxy directly for this object like a true decorator. This is very similar
      # to how something like [draper](https://github.com/jcasimir/draper) works.
      #
      # @param [Symbols*] args name of the properties to accept.  This will be used in the constructor.
      def decorates(*args)
        args.each do |name|
          __delegates << name
        end
      end

      # @private
      def __properties
        @__properties ||= Set.new
      end

      # @private
      def __delegates
        @__delegates ||= Set.new
      end
    end
  end
end
