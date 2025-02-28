# frozen_string_literal: true

module Game
  class Command < BaseCommand
    attr_reader :strategy, :exit_reason

    def initialize(strategy)
      @strategy = strategy
    end

    def play
      strategy.displayer.room_position(strategy.cursor.position.to_s)

      loop do
        @exit_reason = catch(:game_event) do
          strategy.play_moove
          strategy.play_enigma
          strategy.play_fight
        end

        break if exit_reason?
      end

      strategy.displayer.you_are_out(exit_reason)
    end

    private

    def exit_reason?
      return true if exit_reason == :force_exit ||
                     exit_reason == :player_dead ||
                     strategy.end?

      false
    end
  end
end
