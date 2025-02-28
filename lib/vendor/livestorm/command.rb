# frozen_string_literal: true

module Livestorm
  class Command
    attr_reader :displayer

    def initialize
      @displayer = Livestorm::Displayer
    end

    def handle_go
      displayer.ask_for_go
      ready = fetch_console.strip.downcase
      handle_exit!(ready)
      until ready == 'go'
        displayer.ready_to_go
        ready = fetch_console.strip.downcase
        handle_exit!(ready)
      end
    end

    def init_hero
      displayer.ask_for_a_name

      hero_name = fetch_console
      handle_exit!(hero_name)
    end

    def init_difficulty
      displayer.ask_for_a_difficulty

      difficulty = fetch_console
      handle_exit!(difficulty)
    end

    private

    def handle_exit!(input)
      return unless input == 'exit'

      game_displayer.bye
      exit
    end
  end
end
