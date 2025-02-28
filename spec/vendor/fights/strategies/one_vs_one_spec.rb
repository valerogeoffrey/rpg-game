# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fights::Strategies::OneVsOne do
  let(:hero) { double('Hero', points: 100, attacks: { 'punch' => double, 'kick' => double }) }
  let(:bot) { double('Bot', points: 100, attacks: { 'slap' => double, 'punch' => double }) }
  let(:strategy) { described_class.new(hero, bot) }

  describe '#pov_on_hero' do
    it 'sets pov to hero and assigns opponent to bot' do
      strategy.pov_on_hero
      expect(strategy.pov).to eq(hero)
      expect(strategy.opponent).to eq(bot)
    end
  end

  describe '#pov_on_enemy' do
    it 'sets pov to bot and assigns opponent to hero' do
      strategy.pov_on_enemy
      expect(strategy.pov).to eq(bot)
      expect(strategy.opponent).to eq(hero)
    end
  end

  describe '#prevent_no_fighters' do
    context 'when either hero or bot is nil' do
      it 'throws :game_event with :player_not_init' do
        strategy = described_class.new(nil, bot)
        expect { strategy.prevent_no_fighters }.to throw_symbol(:game_event, :player_not_init)

        strategy = described_class.new(hero, nil)
        expect { strategy.prevent_no_fighters }.to throw_symbol(:game_event, :player_not_init)
      end
    end

    context 'when both hero and bot are present' do
      it 'does not throw an error' do
        expect { strategy.prevent_no_fighters }.not_to throw_symbol(:game_event, :player_not_init)
      end
    end
  end

  describe '#prevent_dead_players' do
    context 'when the hero is dead' do
      before { allow(hero).to receive(:points).and_return(0) }

      it 'throws :game_event with :player_dead' do
        expect { strategy.prevent_dead_players }.to throw_symbol(:game_event, :player_dead)
      end
    end

    context 'when the bot is dead' do
      before { allow(bot).to receive(:points).and_return(0) }

      it 'throws :game_event with :player_opponent_dead' do
        expect { strategy.prevent_dead_players }.to throw_symbol(:game_event, :player_opponent_dead)
      end
    end
  end

  describe '#attack_authorize?' do
    before { strategy.pov_on_hero }

    context 'when the attack is valid' do
      it 'does not throw an error' do
        expect { strategy.attack_authorize?(1) }.not_to throw_symbol(:game_event, :player_attack_not_auth)
      end
    end

    context 'when the attack is invalid' do
      it 'throws :game_event with :player_attack_not_auth' do
        expect { strategy.attack_authorize?(10) }.to throw_symbol(:game_event, :player_attack_not_auth)
      end
    end
  end

  describe '#choice_rand_attack' do
    before { strategy.pov_on_hero }

    it 'returns a random attack' do
      allow(strategy).to receive(:choice_rand_attack).and_return(1)
      expect(strategy.choice_rand_attack).to be_between(1, 2)
    end
  end

  describe '#pov_attack' do
    before { strategy.pov_on_hero }

    it 'calls pov.attack and returns the opponent' do
      double('Attack')
      allow(strategy.pov).to receive(:attack).and_return(double)
      expect(strategy.pov_attack(1)).to eq(strategy.opponent)
    end
  end

  describe '#attack_name' do
    before { strategy.pov_on_hero }

    context 'when the attack number is valid' do
      it 'returns the attack name' do
        allow(hero.attacks).to receive(:to_a).and_return([['punch', double], ['kick', double]])
        expect(strategy.attack_name(1)).to eq('punch')
      end
    end

    context 'when the attack number is invalid' do
      before { strategy.pov_on_hero }

      it 'returns :unknow_attack' do
        allow(hero.attacks).to receive(:to_a).and_return([['punch', double], ['kick', double]])
        expect(strategy.attack_name(10)).to eq(:unknow_attack)
      end
    end
  end
end
