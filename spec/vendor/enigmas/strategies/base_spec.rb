# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Enigmas::Strategies::Base do
  let(:enigma) { double('Enigma', good_result?: true) } # Simuler l'énigme
  let(:strategy) { described_class.new(enigma) }

  describe '#initialize' do
    it 'assigns the enigma instance' do
      expect(strategy.enigma).to eq(enigma)
    end
  end

  describe '#good_result?' do
    context 'when answer is correct' do
      it 'returns true' do
        allow(strategy).to receive(:answer).and_return('correct_answer')
        allow(enigma).to receive(:good_result?).with('correct_answer').and_return(true)

        expect(strategy.good_result?).to be true
      end
    end

    context 'when answer is incorrect' do
      it 'returns false' do
        allow(strategy).to receive(:answer).and_return('wrong_answer')
        allow(enigma).to receive(:good_result?).with('wrong_answer').and_return(false)

        expect(strategy.good_result?).to be false
      end
    end

    context 'when answer is nil' do
      it 'returns false' do
        allow(strategy).to receive(:answer).and_return(nil)

        expect(strategy.good_result?).to be false
      end
    end
  end

  describe '#max_try' do
    it 'returns 2 as the max try' do
      expect(strategy.max_try).to eq(2)
    end
  end

  describe '#apply_bonus_malus' do
    context 'when try equals max_try and the answer is wrong' do
      it 'does not apply any bonus or malus' do
        allow(strategy).to receive(:answer).and_return('wrong_answer')
        allow(enigma).to receive(:good_result?).with('wrong_answer').and_return(false)

        expect(strategy.apply_bonus_malus(2)).to be_nil
      end
    end

    context 'when the answer is correct' do
      it 'does not apply malus' do
        allow(strategy).to receive(:answer).and_return('correct_answer')
        allow(enigma).to receive(:good_result?).with('correct_answer').and_return(true)

        expect(strategy.apply_bonus_malus(2)).to be_nil
      end
    end
  end

  describe '#stop_asking?' do
    context 'when the result is correct' do
      it 'returns true' do
        allow(strategy).to receive(:answer).and_return('correct_answer')
        allow(enigma).to receive(:good_result?).with('correct_answer').and_return(true)

        expect(strategy.stop_asking?(1)).to be true
      end
    end

    context 'when max_try is reached' do
      it 'returns true when try equals max_try' do
        allow(strategy).to receive(:answer).and_return('wrong_answer')
        allow(enigma).to receive(:good_result?).with('wrong_answer').and_return(false)

        expect(strategy.stop_asking?(2)).to be true
      end
    end

    context 'when the result is incorrect and max_try is not reached' do
      it 'returns false' do
        allow(strategy).to receive(:answer).and_return('wrong_answer')
        allow(enigma).to receive(:good_result?).with('wrong_answer').and_return(false)

        expect(strategy.stop_asking?(1)).to be false
      end
    end
  end
end
