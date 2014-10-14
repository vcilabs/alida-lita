module Lita
  # Constructs a Lita plugin from a block.
  # @api private
  class Builder
    def initialize(namespace, &block)
      @namespace = namespace.to_s
      @block = block
    end

    # Constructs an {Lita::Adapter} from the provided block.
    def build_adapter
      adapter = create_plugin(Adapter)
      adapter.class_exec(&@block)
      adapter
    end

    # Constructs a {Lita::Handler} from the provided block.
    def build_handler
      handler = create_plugin(Handler)
      handler.instance_exec(&@block)
      handler
    end

    private

    # Creates a class of the relevant plugin type and sets its namespace.
    def create_plugin(plugin_type)
      plugin = Class.new(plugin_type)
      plugin.namespace(@namespace)
      plugin
    end
  end
end
