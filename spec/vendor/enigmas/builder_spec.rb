# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Enigmas::Builder do
  subject { described_class.new(definitions, dependencies) }

  let(:displayer) { double(Enigmas::Displayer) }
  let(:free_strategy) { Enigmas::Strategies::Free }
  let(:choice_strategy) { Enigmas::Strategies::WithChoice }
  let(:resolver) { double('dependencies', resolve: displayer) }
  let(:definitions) do
    [
      { type: :free, name: 'Free Enigma', description: 'A free enigma' },
      { type: :choice, name: 'Choice Enigma', description: 'A choice enigma', choices: ['Choice 1', 'Choice 2'] }
    ]
  end
  let(:dependencies) { resolver }

  describe '#initialize' do
    it 'sets the definitions and dependencies' do
      builder = described_class.new(definitions, dependencies)

      expect(builder.definitions).to eq(definitions)
      expect(builder.dependencies).to eq(dependencies)
    end
  end

  describe '#build' do
    context 'when the definitions are correct' do
      before do
        allow(free_strategy).to receive(:new).and_call_original
        allow(choice_strategy).to receive(:new).and_call_original
      end

      it 'creates a list of enigmas with appropriate strategies' do
        enigmas = subject.build

        expect(enigmas.size).to eq(2)
        expect(enigmas[0].strategy).to be_a(free_strategy)
        expect(enigmas[1].strategy).to be_a(choice_strategy)
      end

      it 'correctly creates Enigma and Command objects' do
        enigmas = subject.build

        expect(enigmas[0].strategy).to be_a(free_strategy)
        expect(enigmas[1].strategy).to be_a(choice_strategy)
        expect(enigmas[0].displayer).to eq(displayer)
        expect(enigmas[1].displayer).to eq(displayer)
      end
    end

    context 'when the definition type is invalid' do
      subject { described_class.new(invalid_definitions, dependencies) }

      let(:invalid_definitions) do
        [
          { type: :unknown, name: 'Unknown Enigma', description: 'An unknown type enigma' }
        ]
      end

      it 'raises an error when an unknown type is encountered' do
        expect { subject.build }.to raise_error(RuntimeError)
      end
    end

    context 'when definitions are empty' do
      subject { described_class.new(empty_definitions, dependencies) }

      let(:empty_definitions) { [] }

      it 'raises an error when definitions are not meet' do
        expect { subject.build }.to raise_error(RuntimeError)
      end
    end
  end
end
