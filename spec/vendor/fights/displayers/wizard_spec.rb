# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fights::Displayers::Wizard do
  let(:player) { double('Player', name: 'Wizard', points: 100, attacks: { 'Fireball' => 50, 'Ice Blast' => 30 }) }
  let(:displayer) { described_class.new }

  describe '#attacks_choice' do
    it 'displays the correct prompt asking the player for a spell choice' do
      expected_output = "> Wizard what spell do you want to use ?\n" \
                        "1 - Fireball\n" \
                        "2 - Ice Blast\n" \
                        "\n" \
                        "> You'r choice ? \n"

      expect { displayer.attacks_choice(player) }.to output(expected_output).to_stdout
    end
  end

  describe '#attack_congrats' do
    it 'displays the correct congratulatory message after an attack' do
      expected_output = "\n# ---------------------------------------------------------------#\n" \
                        "# > You use the spell Fireball Impressive ! Wizard has 100 points left\n"

      expect { displayer.attack_congrats(player, 'Fireball') }.to output(expected_output).to_stdout
    end
  end
end
