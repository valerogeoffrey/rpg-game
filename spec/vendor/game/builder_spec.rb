# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Game::Builder do
  let(:dependencies) { instance_double(Game::Container) }
  let(:configuration) { instance_double(Game::Configuration, with_fights: true, with_enigmas: true) }

  let(:tested_class) { described_class.call(dependencies, options: { configuration: configuration }) }

  before do
    allow(dependencies).to receive(:resolve).with(:game_cursor).and_return(Game::Cursor)
    allow(dependencies).to receive(:resolve).with(:game_displayer).and_return(Game::Displayer.new)
    allow(dependencies).to receive(:resolve).with(:game_strategy).and_return(Game::Strategy)
    allow(dependencies).to receive(:resolve).with(:fight_command).and_return(Fights::Command)
    allow(dependencies).to receive(:resolve).with(:fight_strategy).and_return(Fights::Strategies::OneVsOne)
    allow(dependencies).to receive(:resolve).with(:fight_displayer).and_return(Fights::Displayers::Wizard.new)
    allow(dependencies).to receive(:resolve).with(:enigma_displayer).and_return(Enigmas::Displayer.new)
  end

  describe '#build' do
    it 'builds the rooms' do
      allow(Rooms::Builder).to receive(:call).and_call_original
      config = instance_double(Game::Configuration, with_fights: false, with_enigmas: false)

      described_class.call(dependencies, options: { configuration: config })

      expect(Rooms::Builder).to have_received(:call)
    end

    it 'builds enigmas if with_enigmas is true' do
      config = Game.configure do |c|
        c.with_enigmas = true
        c.with_fights = false
      end
      allow(Enigmas::Builder).to receive(:call).and_call_original

      described_class.call(dependencies, options: { configuration: config })

      expect(Enigmas::Builder).to have_received(:call).with(APP_CONF[:enigmas], dependencies)
    end

    it 'does not build enigmas if with_enigmas is false' do
      config = instance_double(Game::Configuration, with_fights: false, with_enigmas: false)
      allow(Enigmas::Builder).to receive(:call).and_call_original

      described_class.call(dependencies, options: { configuration: config })

      expect(Enigmas::Builder).not_to have_received(:call)
    end

    it 'builds fights if with_fights is true' do
      config = instance_double(Game::Configuration, with_fights: true, with_enigmas: false)

      allow(Enigmas::Builder).to receive(:call).and_call_original
      allow(Characters::Builder).to receive(:call).and_call_original
      allow_any_instance_of(described_class).to receive(:attach_bots_to_rooms)

      klass = described_class.call(dependencies, options: { configuration: config })

      expect(Characters::Builder).to have_received(:call)
      expect(klass).to have_received(:attach_bots_to_rooms)
    end

    it 'does not build fights if with_fights is false' do
      config = instance_double(Game::Configuration, with_fights: false, with_enigmas: false)
      allow(Characters::Builder).to receive(:call).and_call_original

      described_class.call(dependencies, options: { configuration: config })

      expect(Characters::Builder).not_to have_received(:call)
    end

    it 'builds strategy' do
      config = instance_double(Game::Configuration, with_fights: false, with_enigmas: false)
      builder_instance = described_class.new(dependencies, options: { configuration: config })
      allow(builder_instance).to receive(:build_strategy).and_call_original

      builder_instance.build

      expect(builder_instance).to have_received(:build_strategy)
      expect(dependencies).to have_received(:resolve).with(:game_strategy)
    end
  end

  describe '#attach_bots_to_rooms' do
    it 'attaches bots to rooms if should_add_bot? returns true' do
      config = instance_double(Game::Configuration, with_fights: true, with_enigmas: false)
      rooms = Rooms::Builder.call
      builder_instance = described_class.new(dependencies, options: { configuration: config })
      allow(builder_instance).to receive_messages(map: rooms, should_add_bot?: true, shuffled_bots: true)
      allow(builder_instance).to receive(:attach_bots_to_rooms).and_call_original

      klass = builder_instance.build

      expect(klass.strategy.cursor.map.first.last.bot.class).to eq(Fights::Command)
    end

    it 'does not attach bots if should_add_bot? returns false' do
      config = instance_double(Game::Configuration, with_fights: false, with_enigmas: false)
      builder_instance = described_class.new(dependencies, options: { configuration: config })

      klass = builder_instance.build

      expect(klass.strategy.cursor.map.first.last.bot).to be_nil
    end
  end
end
