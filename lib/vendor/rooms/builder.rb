# frozen_string_literal: true

module Rooms
  class Builder < BaseBuilder
    attr_reader :definitions

    def initialize(definitions = APP_CONF[:rooms])
      @definitions = definitions

      super()
    end

    def build
      rooms = {}
      definitions.map do |room_definition|
        rooms[room_definition[:id]] = Room.new(room_definition.slice(*Room::ALLOWED_KEYS))
      end

      rooms
    end
  end
end
