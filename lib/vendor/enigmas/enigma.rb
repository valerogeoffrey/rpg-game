# frozen_string_literal: true

class Enigma
  ALLOWED_KEYS = %i[question answer choices type].freeze
  attr_accessor(*ALLOWED_KEYS)

  def initialize(attributes)
    attributes.each do |key, value|
      send(:"#{key}=", value)
    end
  end

  def good_result?(input)
    input.to_s == answer.to_s
  end
end
