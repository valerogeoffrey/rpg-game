# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Characters::Builder do
  describe '.call' do
    let(:characters_data) do
      {
        'Hero' => { attacks: %w[punch kick], health: 100 },
        'Villain' => { attacks: %w[fireball smash], health: 80 }
      }
    end

    let(:character_instances) do
      characters_data.map do |name, _|
        instance_double(Characters::Character, name: name)
      end
    end

    before do
      allow(APP_CONF).to receive(:[]).with(:characters).and_return(characters_data)
      characters_data.each do |name, definition|
        allow(Characters::Character).to receive(:new).with(definition.with_indifferent_access.merge(name: name)).and_return(instance_double(
          Characters::Character, name: name
        ))
      end
    end

    it 'returns an array of character instances' do
      result = described_class.call

      expect(result).to be_an(Array)
      expect(result.size).to eq(characters_data.size)
      expect(result.map(&:name)).to match_array(characters_data.keys)
    end
  end

  describe '.pick_one' do
    let(:sampled_character) { instance_double(Characters::Character, name: 'Hero') }

    before do
      allow(described_class).to receive(:call).and_return([sampled_character])
    end

    it 'returns a random character from the call result' do
      result = described_class.pick_one

      expect(result).to eq(sampled_character)
    end
  end
end
