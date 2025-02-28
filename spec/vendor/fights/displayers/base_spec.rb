# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fights::Displayers::Base do
  let(:player) { double('Player', name: 'Hero', points: 100) }
  let(:displayer) { described_class.new }

  describe '#attack_issue' do
    it 'displays the correct message when the attack misses' do
      expect { displayer.attack_issue }.to output("You have miss you'r enemy\n").to_stdout
    end
  end

  describe '#player_is_dead' do
    it 'displays the correct message when the player is dead' do
      expect { displayer.player_is_dead }.to output("You'r dead :(\n").to_stdout
    end
  end

  describe '#enemy_is_dead' do
    it 'displays the correct message when the enemy is dead' do
      expect { displayer.enemy_is_dead }.to output(
        "# You'r enemy is dead !! Wooaaaaaaaa , congratulations !\n" \
        "# ---------------------------------------------------------------#\n"
      ).to_stdout
    end
  end

  describe '#enemy_attack' do
    it 'displays the correct message when the enemy attacks' do
      expect { displayer.enemy_attack(player) }.to output(
        "# Be carreful ! Your enemy want to revenge ! \n" \
        "# > You have been hit from your enemy, You have 100 points left\n" \
        "# \n" \
        "# ---------------------------------------------------------------#\n " \
        "\n"
      ).to_stdout
    end
  end

  describe '#attack_your_enemy' do
    it 'displays the correct message when the player hits the enemy' do
      expect { displayer.attack_your_enemy(player) }.to output(
        "# > You have hit you'r enemy, Hero has 100 left\n"
      ).to_stdout
    end
  end

  describe '#emergency_exit' do
    it 'displays the correct message when the player exits the fight' do
      expect { displayer.emergency_exit }.to output("> Smart ! You have exit the fight !\n").to_stdout
    end
  end
end
