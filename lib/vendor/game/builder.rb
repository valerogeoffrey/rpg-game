# frozen_string_literal: true

module Game
  class Builder < BaseBuilder
    attr_reader :strategy, :config, :dependencies

    def initialize(dependencies, options: {})
      @dependencies = dependencies
      @config = options[:configuration] || Game.configuration

      super()
    end

    def build
      map = build_rooms
      build_enigmas(map)
      build_fights(map)
      build_strategy(map)

      self
    end

    private

    def build_fights(map)
      return unless config.with_fights

      bots = Characters::Builder.call
      attach_bots_to_rooms(bots, map)
    end

    def build_rooms
      Rooms::Builder.call
    end

    def build_enigmas(map)
      return unless config.with_enigmas

      enigmas = Enigmas::Builder.call(APP_CONF[:enigmas], dependencies)
      shuffled_enigmas = enigmas.shuffle

      map.to_a.shuffle.each do |_, room|
        room.enigma = shuffled_enigmas.pop if shuffled_enigmas.any?
      end
    end

    def attach_enigmas_to_rooms(enigmas, rooms)
      shuffled_enigmas = enigmas.shuffle
      rooms.to_a.shuffle.each_value do |room|
        room.enigma = shuffled_enigmas.pop if shuffled_enigmas.any?
      end
    end

    def attach_bots_to_rooms(bots, rooms)
      shuffled_bots = bots.shuffle
      rooms.to_a.shuffle.each do |_, room|
        next unless should_add_bot?

        bot = shuffled_bots.sample
        next unless bot

        room.bot = dependencies.resolve(:fight_command).new(
          dependencies.resolve(:fight_strategy).new(hero_instance, bot),
          dependencies.resolve(:fight_displayer)
        )
      end
    end

    def should_add_bot?
      rand < 0.66
    end

    def build_strategy(map)
      cursor = dependencies.resolve(:game_cursor).new(map)
      displayer = dependencies.resolve(:game_displayer)
      @strategy = dependencies.resolve(:game_strategy).new(map, cursor, displayer)
    end
  end
end
