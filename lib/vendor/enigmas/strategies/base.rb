# frozen_string_literal: true

module Enigmas
  module Strategies
    class Base
      attr_reader :enigma
      attr_accessor :answer

      def initialize(enigma)
        @enigma = enigma
      end

      def question
        raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
      end

      def good_result?
        return false unless answer

        enigma.good_result?(answer)
      end

      def max_try
        2
      end

      def apply_bonus_malus(try)
        if try == max_try && !good_result?
          # add Malus /  sub points / sub items inventory / move in previous rooms etc...
          # Observer.update('reset_position', true)
        end

        nil unless good_result?

        # add Bonus /  add points / add items inventory / move in previous rooms etc...
      end

      def stop_asking?(try)
        good_result? || try == max_try
      end
    end
  end
end
