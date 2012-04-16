module Prospecto
  class View
    # lookup_context is required for rspec integration to work.
    attr_reader :lookup_context

    def self.accepts(*names)
      attr_accessor *names
      define_method :initialize do |args={}|
        args.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
