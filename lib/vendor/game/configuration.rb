# frozen_string_literal: true

module Game
  class Configuration
    attr_accessor(*APP_CONF[:game].keys.map(&:to_sym))

    def initialize
      APP_CONF[:game].each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
