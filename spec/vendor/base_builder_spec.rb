# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BaseBuilder do
  describe '.call' do
    it 'calls #build on a new instance' do
      builder_instance = instance_double(described_class, build: 'result')
      allow(described_class).to receive(:new).and_return(builder_instance)

      result = described_class.call

      expect(described_class).to have_received(:new)
      expect(builder_instance).to have_received(:build)
      expect(result).to eq('result')
    end
  end

  describe '#build' do
    it 'raises a NotImplementedError' do
      builder = described_class.new

      expect { builder.build }.to raise_error(NotImplementedError, /BaseBuilder has not implemented build/)
    end
  end
end
