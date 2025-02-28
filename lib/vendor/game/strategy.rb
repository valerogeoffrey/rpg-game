# frozen_string_literal: true

module Game
  class Strategy
    attr_accessor :map, :cursor, :room, :enigma, :fight, :displayer

    def initialize(map, cursor, displayer)
      @map = map
      @cursor = cursor
      @displayer = displayer
    end

    def end?
      cursor.final_room?
    end

    def play_enigma
      return unless Game.configuration.with_enigmas
      return unless enigma

      status = enigma.play
      handle_force_exit(status)
    end

    def play_moove
      ask_for_moove
      moove = fetch_console
      handle_force_exit(moove)

      msg = catch(:moove_error) { cursor.moove_to(moove) }
      if msg == :invalid_moove
        displayer.invalid_moove
        return
      end

      set_cursor_actions
      display_position
    end

    def play_fight
      return unless Game.configuration.with_fights
      return unless fight

      msg = catch(:game_error) { fight.play }
      handle_force_exit(msg) do
        fight.displayer.emergency_exit
      end

      fight.strategy.prevent_dead_player
    end

    private

    def handle_force_exit(status, &block)
      return unless status && (status.to_sym == :exit || status.to_sym == :force_exit)

      block&.call

      displayer.emergency_exit
      throw(:game_event, :force_exit)
    end

    def set_cursor_actions
      @enigma = cursor.room.enigma
      @fight = cursor.room.bot
    end

    def display_position
      displayer.room_position(cursor.position.to_s)
    end

    def ask_for_moove
      displayer.ask_for_moove(cursor.available_moves.join(' / '))
    end
  end
end
