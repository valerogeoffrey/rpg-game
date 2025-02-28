# frozen_string_literal: true

class Room
  ALLOWED_KEYS = %i[id name description first_room last_room moves].freeze
  attr_accessor(*ALLOWED_KEYS, :enigma, :bot)

  def initialize(attributes)
    attributes.each do |key, value|
      send(:"#{key}=", value)
    end
  end

  def first_room?
    first_room
  end

  def last_room?
    last_room
  end
end
