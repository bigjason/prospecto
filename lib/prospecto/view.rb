module Prospecto
  class View
    # lookup_context is required for rspec integration to work.
    attr_reader :lookup_context

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
      alias :accepts :attr_reader
    end
  end
end
