# frozen_string_literal: true

module Characters
  class Builder
    def self.call(*args, **kwargs)
      new(*args, **kwargs).build
    end

    def build
      characters = []
      APP_CONF[:characters].each do |character_name, definition|
        definition = definition.with_indifferent_access
        definition[:name] = character_name

        characters << Characters::Character.new(definition)
      end

      characters
    end

    def self.pick_one
      call.sample
    end
  end
end
