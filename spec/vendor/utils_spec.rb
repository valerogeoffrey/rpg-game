# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Console methods' do
  describe '#fetch_console' do
    before do
      allow($stdin).to receive(:gets).and_return("test\n")
    end

    it 'returns a string by default' do
      expect(fetch_console).to eq('test')
    end

    it 'returns an integer when type is :integer' do
      allow($stdin).to receive(:gets).and_return("42\n")
      expect(fetch_console(:integer)).to eq(42)
    end

    it 'returns a symbol when type is :sym' do
      allow($stdin).to receive(:gets).and_return("hello\n")
      expect(fetch_console(:sym)).to eq(:hello)
    end
  end

  describe '#hero_instance' do
    it 'returns the same instance of Characters::Hero' do
      hero1 = hero_instance
      hero2 = hero_instance
      expect(hero1).to be(hero2)
    end
  end
end
