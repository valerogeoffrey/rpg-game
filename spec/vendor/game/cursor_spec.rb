# frozen_string_literal: true

# spec/game/cursor_spec.rb

require 'spec_helper'

RSpec.describe Game::Cursor do
  let(:room1) { double('Room', moves: { north: 2, south: 3 }, last_room: false) }
  let(:room2) { double('Room', moves: { south: 1 }, last_room: false) }
  let(:room3) { double('Room', moves: { north: 1 }, last_room: true) } # Dernière salle

  let(:map) { { 1 => room1, 2 => room2, 3 => room3 } }
  let(:cursor) { described_class.new(map) }

  describe '#initialize' do
    it 'initializes with the correct attributes' do
      expect(cursor.map).to eq(map)
      expect(cursor.available_position).to eq([1, 2, 3])
      expect(cursor.position).to eq(1)
    end
  end

  describe '#moove_to' do
    context 'with a valid move' do
      it 'updates the position correctly' do
        expect(cursor.moove_to(:north)).to eq(2)
        expect(cursor.position).to eq(2)
      end
    end

    context 'with an invalid move' do
      it 'throws a :moove_error symbol' do
        expect { cursor.moove_to(:west) }.to throw_symbol(:moove_error, :invalid_moove)
      end
    end
  end

  describe '#set_moove' do
    context 'with a valid move' do
      it 'sets the moove attribute' do
        cursor.set_moove(:north)
        expect(cursor.moove).to eq(:north)
      end
    end

    context 'with an invalid move' do
      it 'throws a :moove_error symbol' do
        expect { cursor.set_moove(:west) }.to throw_symbol(:moove_error, :invalid_moove)
      end
    end
  end

  describe '#final_room?' do
    it 'returns false if the current room is not the final room' do
      expect(cursor.final_room?).to be false
    end

    it 'returns true if the current room is the final room' do
      cursor.moove_to(:south)
      expect(cursor.final_room?).to be true
    end
  end

  describe '#available_moves' do
    it 'returns the possible moves for the current room' do
      expect(cursor.available_moves).to eq(%i[north south])
    end
  end

  describe '#room' do
    it 'returns the current room' do
      expect(cursor.room).to eq(room1)
    end
  end

  describe '#next_room' do
    context 'when a move is set' do
      it 'returns the next room based on the move' do
        cursor.set_moove(:north)
        expect(cursor.next_room).to eq(2)
      end
    end

    context 'when no move is set' do
      it 'returns nil' do
        expect(cursor.next_room).to be_nil
      end
    end
  end
end
