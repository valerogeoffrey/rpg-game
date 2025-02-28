# frozen_string_literal: true

# spec/vendor/game/container_spec.rb

require 'spec_helper'

RSpec.describe Game::Container do
  let(:container) { described_class.new }

  describe '#resolve' do
    it 'resolves the correct dependencies' do
      expect(container.resolve(:game_displayer)).to be_an_instance_of(Game::Displayer)
      expect(container.resolve(:enigma_displayer)).to be_an_instance_of(Enigmas::Displayer)
      expect(container.resolve(:fight_displayer)).to be_an_instance_of(Fights::Displayers::Wizard)
      expect(container.resolve(:fight_strategy)).to eq(Fights::Strategies::OneVsOne)
      expect(container.resolve(:game_strategy)).to eq(Game::Strategy)
      expect(container.resolve(:game_cursor)).to eq(Game::Cursor)
      expect(container.resolve(:fight_command)).to eq(Fights::Command)
    end
  end

  describe '#dependencies' do
    it 'returns the correct dependencies' do
      expected_dependencies = {
        game_displayer: instance_of(Game::Displayer),
        enigma_displayer: instance_of(Enigmas::Displayer),
        fight_displayer: instance_of(Fights::Displayers::Wizard),
        fight_strategy: Fights::Strategies::OneVsOne,
        game_strategy: Game::Strategy,
        game_cursor: Game::Cursor,
        fight_command: Fights::Command
      }

      expected_dependencies.each do |key, value|
        expect(container.dependencies[key]).to be_an_instance_of(value.class) if value.is_a?(Class)
        expect(container.dependencies[key]).to eq(value) if value.is_a?(Module)
      end
    end
  end
end
