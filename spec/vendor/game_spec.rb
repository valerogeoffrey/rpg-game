# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Game do
  describe '.configuration' do
    it 'returns a singleton instance of Configuration' do
      config1 = described_class.configuration
      config2 = described_class.configuration

      expect(config1).to be_a(Game::Configuration)
      expect(config1).to be(config2)
    end
  end

  describe '.configure' do
    it 'yields the configuration object' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(described_class.configuration)
    end

    it 'allows modification of the configuration' do
      described_class.configure do |config|
        config.difficulty = 1
      end

      expect(described_class.configuration.difficulty).to eq(1)
    end
  end

  describe '.start' do
    let(:hero_instance) { instance_double(Characters::Character, name: nil) }
    let(:container) { instance_double(Game::Container) }
    let(:game_instance) { instance_double(Game::Builder) }
    let(:game_strategy) { instance_double(Game::Strategy) }
    let(:game_command) { instance_double(Game::Command) }

    before do
      allow(Characters::Hero).to receive(:instance).and_return(hero_instance)
      allow(hero_instance).to receive(:name=)

      allow(Game::Container).to receive(:new).and_return(container)
      allow(Game::Builder).to receive(:call).and_return(game_instance)
      allow(game_instance).to receive(:strategy).and_return(game_strategy)

      allow(Game::Command).to receive(:new).and_return(game_command)
      allow(game_command).to receive(:play)
    end

    it 'sets the hero name' do
      described_class.start('Arthur')

      expect(hero_instance).to have_received(:name=).with('Arthur')
    end

    it 'initializes a Container' do
      described_class.start('Arthur')

      expect(Game::Container).to have_received(:new)
    end

    it 'calls Game::Builder with the container and configuration' do
      described_class.start('Arthur')

      expect(Game::Builder).to have_received(:call).with(container,
        options: { configuration: described_class.configuration })
    end

    it 'retrieves the game strategy and plays the game' do
      described_class.start('Arthur')

      expect(game_instance).to have_received(:strategy)
      expect(Game::Command).to have_received(:new).with(game_strategy)
      expect(game_command).to have_received(:play)
    end
  end
end
