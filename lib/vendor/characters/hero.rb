# frozen_string_literal: true

module Characters
  class Hero
    include Singleton

    attr_accessor :hero

    def self.reset_instance
      @@instance = nil
    end

    def self.instance
      @@instance ||= new.hero
    end

    def initialize
      @hero = Characters::Character.new(definition)
    end

    private

    def definition
      APP_CONF[:hero] unless Game.configuration.cheat_mode

      APP_CONF[:hero].tap do |defn|
        if Game.configuration.cheat_mode
          defn[:attacks].transform_values! { |v| v * 2 }
          defn[:attacks]['avada kedavra'] = 200
        end
      end
    end
  end
end
