# frozen_string_literal: true

# spec/vendor/game/strategy_spec.rb

require 'spec_helper'

RSpec.describe Game::Strategy do
  let(:container) { Game::Container.new }
  let(:configuration) { Game.configuration }
  let(:cursor) { strategy.cursor }
  let(:displayer) { strategy.displayer }
  let(:strategy) { Game::Builder.call(container, options: { configuration: configuration }).strategy }

  describe '#end?' do
    it 'returns true if cursor is in the final room' do
      allow(strategy.cursor).to receive(:final_room?).and_return(true)
      expect(strategy.end?).to be true
    end

    it 'returns false if cursor is not in the final room' do
      allow(cursor).to receive(:final_room?).and_return(false)
      expect(strategy.end?).to be false
    end
  end

  describe '#play_enigma' do
    context 'when enigmas are enabled' do
      let(:enigma) { double('Enigma') }

      before do
        allow(Game.configuration).to receive(:with_enigmas).and_return(true)
        strategy.enigma = enigma
        allow(enigma).to receive(:play).and_return(:success)
        allow(strategy).to receive(:handle_force_exit)
      end

      it 'plays the enigma and handles the exit if necessary' do
        strategy.play_enigma
        allow(strategy).to receive(:handle_force_exit)

        expect(enigma).to have_received(:play)
      end

      it 'does not play the enigma if no enigma is present' do
        strategy.enigma = nil
        strategy.play_enigma
        allow(strategy).to receive(:handle_force_exit)
        expect(strategy).not_to have_received(:handle_force_exit)
      end
    end

    context 'when enigmas are not enabled' do
      before do
        allow(Game.configuration).to receive(:with_enigmas).and_return(false)
      end

      it 'does not play the enigma' do
        strategy.play_enigma
        allow(strategy).to receive(:handle_force_exit)
        expect(strategy).not_to have_received(:handle_force_exit)
      end
    end
  end

  describe '#play_moove' do
    let(:moove) { 'left' }

    before do
      allow(displayer).to receive(:ask_for_moove)
      allow(strategy).to receive(:fetch_console).and_return(moove)
      allow(strategy).to receive(:set_cursor_actions)
      allow(strategy).to receive(:display_position)
    end

    it 'handles invalid move and displays the message' do
      allow(cursor).to receive(:moove_to).and_return(:invalid_moove)
      allow(displayer).to receive(:invalid_moove).and_return(nil)

      expect do
        strategy.play_moove
      end.to output('').to_stdout

      expect(displayer).to have_received(:invalid_moove)
    end

    it 'sets the cursor actions and displays position after the move' do
      allow(cursor).to receive(:moove_to).and_return(nil)
      allow(strategy).to receive(:set_cursor_actions)
      allow(strategy).to receive(:display_position)

      strategy.play_moove

      expect(strategy).to have_received(:set_cursor_actions)
      expect(strategy).to have_received(:display_position)
    end
  end

  describe '#play_fight' do
    context 'when fights are enabled' do
      let(:fight_command) do
        Fights::Command.new(
          Fights::Strategies::OneVsOne.new(Characters::Hero.instance, Characters::Builder.call.sample),
          Fights::Displayers::Wizard.new
        )
      end

      before do
        allow(Game.configuration).to receive(:with_fights).and_return(true)
        strategy.fight = fight_command
        allow(fight_command).to receive(:play).and_return(:success)
        allow(strategy).to receive(:handle_force_exit)
      end

      it 'plays the fight and handles the exit if necessary' do
        strategy.play_fight
        expect(fight_command).to have_received(:play)
      end

      it 'does not play the fight if no fight is present' do
        strategy.fight = nil
        strategy.play_fight
        allow(strategy).to receive(:handle_force_exit)
        expect(strategy).not_to have_received(:handle_force_exit)
      end
    end

    context 'when fights are not enabled' do
      before do
        allow(Game.configuration).to receive(:with_fights).and_return(false)
      end

      it 'does not play the fight' do
        strategy.play_fight
        allow(strategy).to receive(:handle_force_exit)
        expect(strategy).not_to have_received(:handle_force_exit)
      end
    end
  end

  describe '#handle_force_exit' do
    it 'calls the block and exits when status is :exit' do
      allow(displayer).to receive(:emergency_exit)
      expect { strategy.send(:handle_force_exit, :exit) }.to throw_symbol(:game_event, :force_exit)
    end

    it 'does not exit when status is not :exit' do
      allow(displayer).to receive(:emergency_exit)
      expect { strategy.send(:handle_force_exit, :success) }.not_to throw_symbol(:game_event, :force_exit)
    end
  end
end
