# frozen_string_literal: true

module Game
  class Cursor
    attr_reader :map, :available_position, :position
    attr_accessor :moove

    def initialize(map)
      @map = map
      @available_position = map.keys
      @position = @available_position.first
    end

    def moove_to(value)
      position = set_moove(value).next_room

      @position = position

      position
    end

    def set_moove(moove) # rubocop:disable Naming/AccessorMethodName
      throw :moove_error, :invalid_moove unless valid_moove? moove

      @moove = moove.to_sym
      self
    end

    def final_room?
      room.last_room
    end

    def available_moves
      room.moves.keys
    end

    def room
      map[position]
    end

    def next_room
      room.moves[moove]
    end

    private

    def valid_moove?(moove)
      available_moves.include?(moove)
    end
  end
end
