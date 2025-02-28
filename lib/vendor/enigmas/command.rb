# frozen_string_literal: true

module Enigmas
  class Command < BaseCommand
    attr_accessor :strategy, :displayer

    def initialize(strategy, displayer)
      @displayer = displayer
      @strategy = strategy
      @try = 0
    end

    def play
      displayer.introduction
      loop do
        @try += 1
        displayer.ask_question(strategy.question)
        answer = fetch_console(:sym)
        strategy.answer = answer
        throw :game_event, :force_exit if answer == :exit

        displayer.try_again(try_left) unless strategy.good_result?
        break if excedded_try?

        if strategy.good_result?
          displayer.congratulation
          break
        end
      end

      reset_trying
      strategy.apply_bonus_malus(try)
    end

    private

    attr_accessor :try

    def try_left
      strategy.max_try - try
    end

    def excedded_try?
      return false if Game.configuration.cheat_mode
      return false unless try >= strategy.max_try && !strategy.good_result?

      displayer.excedded_try
      true
    end

    def reset_trying
      @try = 0
    end
  end
end
