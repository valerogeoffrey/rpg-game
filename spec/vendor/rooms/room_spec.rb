# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Room do
  subject(:room) { described_class.new(attributes) }

  let(:attributes) do
    {
      id: 1,
      name: 'Dark Chamber',
      description: 'A gloomy room with a flickering candle.',
      first_room: false,
      last_room: true,
      moves: { north: 2, south: 3 }
    }
  end

  describe '#initialize' do
    it 'assigns the correct attributes' do
      expect(room.id).to eq(1)
      expect(room.name).to eq('Dark Chamber')
      expect(room.description).to eq('A gloomy room with a flickering candle.')
      expect(room.first_room).to be(false)
      expect(room.last_room).to be(true)
      expect(room.moves).to eq({ north: 2, south: 3 })
    end
  end

  describe '#first_room?' do
    it 'returns true if it is the first room' do
      room.first_room = true
      expect(room.first_room?).to be true
    end

    it 'returns false if it is not the first room' do
      room.first_room = false
      expect(room.first_room?).to be false
    end
  end

  describe '#last_room?' do
    it 'returns true if it is the last room' do
      expect(room.last_room?).to be true
    end

    it 'returns false if it is not the last room' do
      room.last_room = false
      expect(room.last_room?).to be false
    end
  end

  describe 'dynamic attributes' do
    it 'allows setting and getting enigma' do
      room.enigma = 'A tricky puzzle'
      expect(room.enigma).to eq('A tricky puzzle')
    end

    it 'allows setting and getting bot' do
      room.bot = 'A fierce warrior'
      expect(room.bot).to eq('A fierce warrior')
    end
  end
end
