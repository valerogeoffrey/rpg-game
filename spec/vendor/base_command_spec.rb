# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BaseCommand do
  describe '#play' do
    it 'raises a NotImplementedError' do
      command = described_class.new

      expect { command.play }.to raise_error(NotImplementedError, /BaseCommand has not implemented play/)
    end
  end
end
