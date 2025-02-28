# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rooms::Builder do
  subject { described_class.new(room_definitions) }

  let(:room_definitions) do
    [
      {
        id: 1,
        name: 'Hall',
        description: 'A large entrance hall.',
        first_room: true,
        last_room: false,
        moves: { forward: 2 }
      },
      { id: 2, name: 'Dungeon', description: 'A dark, damp dungeon.',
        first_room: false,
        last_room: true,
        moves: {} }
    ]
  end

  describe '#initialize' do
    it 'assigns definitions from given parameter' do
      expect(subject.definitions).to eq(room_definitions)
    end

    it 'assigns definitions from APP_CONF[:rooms] when no parameter is given' do
      stub_const('APP_CONF', { rooms: room_definitions })
      expect(described_class.new.definitions).to eq(room_definitions)
    end
  end

  describe '#build' do
    let(:built_rooms) { subject.build }

    it 'returns a hash of Room objects indexed by id' do
      expect(built_rooms).to be_a(Hash)
      expect(built_rooms.keys).to contain_exactly(1, 2)
      expect(built_rooms.values).to all(be_a(Room))
    end

    it 'creates rooms with correct attributes' do
      room1 = built_rooms[1]
      room2 = built_rooms[2]

      expect(room1.name).to eq('Hall')
      expect(room1.description).to eq('A large entrance hall.')
      expect(room1.first_room).to be(true)
      expect(room1.last_room).to be(false)
      expect(room1.moves).to eq({ forward: 2 })

      expect(room2.name).to eq('Dungeon')
      expect(room2.description).to eq('A dark, damp dungeon.')
      expect(room2.first_room).to be(false)
      expect(room2.last_room).to be(true)
      expect(room2.moves).to eq({})
    end

    it 'only keeps allowed keys when creating rooms' do
      allow(Room).to receive(:new)
      allowed_keys = Room::ALLOWED_KEYS
      room_data = room_definitions.first

      subject.build

      expect(Room).to have_received(:new).with(room_data.slice(*allowed_keys))
    end
  end
end
