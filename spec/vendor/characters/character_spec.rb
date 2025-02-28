# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Characters::Character do
  let(:attacks) { { punch: 10, kick: 15 } }
  let(:character_attributes) { { name: 'Hero', points: 100, attacks: attacks } }
  let(:character) { described_class.new(character_attributes) }
  let(:target) { instance_double(described_class, points: 100) }

  before do
    allow(target).to receive(:points=)
  end

  describe '#attack' do
    context 'when the attack is valid' do
      it 'reduces the target points based on the attack' do
        allow(target).to receive(:points=)

        character.attack(target, :punch)

        expect(target).to have_received(:points=).with(90)
      end

      it 'returns true after a successful attack' do
        result = character.attack(target, :punch)

        expect(result).to be(true)
      end
    end

    context 'when the attack is invalid' do
      it 'throws :game_event if the attack is unknown' do
        result = catch(:game_event) { character.attack(target, :unknown_attack) }

        expect(result).to eq(:player_attack_unknown)
      end

      it 'throws :game_event if the target is dead' do
        allow(character).to receive(:dead?).and_return(true)
        result = catch(:game_event) { character.attack(target, :punch) }

        expect(result).to eq(:player_dead)
      end
    end
  end

  describe '#can_attack?' do
    it 'throws :game_event if the attack is not available' do
      expect { character.send(:can_attack?, :unknown_attack) }.to throw_symbol(:game_event)
    end

    it 'throws :game_event if the player is dead' do
      allow(character).to receive(:dead?).and_return(true)
      expect { character.send(:can_attack?, :punch) }.to throw_symbol(:game_event)
    end
  end

  describe '#dead?' do
    it 'returns true when points are less than or equal to 0' do
      character.points = 0

      expect(character.send(:dead?)).to be(true)
    end

    it 'returns false when points are greater than 0' do
      character.points = 10

      expect(character.send(:dead?)).to be(false)
    end
  end
end
