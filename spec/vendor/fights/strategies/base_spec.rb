# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fights::Strategies::Base do
  let(:strategy) { described_class.new }

  describe '#prevent_dead_players' do
    it 'raises a NotImplementedError' do
      expect do
        strategy.prevent_dead_players
      end.to raise_error(NotImplementedError, /has not implemented prevent_dead_players/)
    end
  end

  describe '#player_dead?' do
    it 'raises a NotImplementedError' do
      expect { strategy.player_dead? }.to raise_error(NotImplementedError, /has not implemented player_dead\?/)
    end
  end

  describe '#enemy_dead?' do
    it 'raises a NotImplementedError' do
      expect { strategy.enemy_dead? }.to raise_error(NotImplementedError, /has not implemented enemy_dead\?/)
    end
  end

  describe '#attack_authorize?' do
    it 'raises a NotImplementedError' do
      expect do
        strategy.attack_authorize?(double)
      end.to raise_error(NotImplementedError, /has not implemented attack_authorize\?/)
    end
  end

  describe '#choice_rand_attack' do
    it 'raises a NotImplementedError' do
      expect do
        strategy.choice_rand_attack
      end.to raise_error(NotImplementedError, /has not implemented choice_rand_attack/)
    end
  end

  describe '#attack_name' do
    it 'raises a NotImplementedError' do
      expect { strategy.attack_name(double) }.to raise_error(NotImplementedError, /has not implemented attack_name/)
    end
  end
end
