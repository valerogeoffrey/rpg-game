# frozen_string_literal: true

module Enigmas
  class Builder < BaseBuilder
    attr_reader :definitions, :dependencies

    def initialize(definitions, dependencies)
      @definitions = definitions
      @dependencies = dependencies

      super()
    end

    def build
      enigmas = []
      displayer = dependencies.resolve(:enigma_displayer)

      raise 'Empty definition' if definitions.empty?

      definitions.map do |enigma_definition|
        strategy = case enigma_definition[:type].to_sym
                   when :free then Strategies::Free
                   when :choice then Strategies::WithChoice
                   else
                     raise "Unknown enigma type: #{enigma_definition[:type]}"
                   end

        definition = enigma_definition.slice(*Enigma::ALLOWED_KEYS)
        raise 'Invalid definition' unless definition.keys.map(&:to_sym).all? do |key|
          Enigma::ALLOWED_KEYS.include?(key)
        end

        enigma = Enigma.new(definition)
        enigmas << Enigmas::Command.new(strategy.new(enigma), displayer)
      end

      enigmas
    end
  end
end
