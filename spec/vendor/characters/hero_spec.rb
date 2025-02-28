# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Characters::Hero do
  describe '.instance' do
    it 'returns the same instance every time' do
      first_instance = described_class.instance
      second_instance = described_class.instance

      expect(first_instance).to be(second_instance)
    end
  end

  describe 'cheat_mode' do
    context 'when cheat_mode is enabled' do
      it 'adds a super attack' do
        Game.configure { |config| config.cheat_mode = true }
        described_class.reset_instance

        c1 = described_class.instance
        expect(c1.attacks['avada kedavra']).to eq(200)
      end
    end
  end
end
