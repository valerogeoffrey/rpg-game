# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Enigmas::Displayer do
  let(:displayer) { described_class.new }

  before do
    # Interceptons les appels à puts et capturons les sorties
    allow($stdout).to receive(:puts)
  end

  describe '#ask_question' do
    it 'prints the question stripped of leading and trailing spaces' do
      question = '  What is the answer?  '
      displayer.ask_question(question)

      expect($stdout).to have_received(:puts).with('What is the answer?')
    end
  end

  describe '#congratulation' do
    it 'prints a congratulation message' do
      displayer.congratulation

      expect($stdout).to have_received(:puts).with("> Congratulation, you'r right ! ")
      expect($stdout).to have_received(:puts).with('')
    end
  end

  describe '#excedded_try' do
    it 'prints the exceeded try message' do
      displayer.excedded_try

      expect($stdout).to have_received(:puts).with('> you have reach the response limit :( ')
    end
  end

  describe '#introduction' do
    it 'prints the introduction message' do
      displayer.introduction

      expect($stdout).to have_received(:puts).with("> Before you can gout out of ths rooms, you'll have to solve a little riddle")
    end
  end

  describe '#try_again' do
    it 'prints the try_again message with the correct number of remaining tries' do
      displayer.try_again(3)

      expect($stdout).to have_received(:puts).with("> it's not correct ! you still have 3 try ")
    end
  end
end
