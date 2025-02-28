# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Enigma do
  let(:valid_attributes) do
    {
      question: 'What is 2 + 2?',
      answer: 4,
      choices: [2, 3, 4, 5],
      type: :free
    }
  end

  describe '#initialize' do
    it 'assigns attributes correctly' do
      enigma = described_class.new(valid_attributes)

      expect(enigma.question).to eq('What is 2 + 2?')
      expect(enigma.answer).to eq(4)
      expect(enigma.choices).to eq([2, 3, 4, 5])
      expect(enigma.type).to eq(:free)
    end
  end

  describe '#good_result?' do
    let(:enigma) { described_class.new(valid_attributes) }

    it 'returns true when the input is correct' do
      expect(enigma.good_result?(4)).to be true
    end

    it 'returns false when the input is incorrect' do
      expect(enigma.good_result?(5)).to be false
    end

    it 'returns true when the input matches the answer as a string' do
      expect(enigma.good_result?('4')).to be true
    end

    it 'returns false when the input does not match the answer as a string' do
      expect(enigma.good_result?('5')).to be false
    end
  end
end
