# frozen_string_literal: true

module Enigmas
  module Strategies
    class WithChoice < Base
      def question
        enigma.question + " - one choice - ( #{enigma.choices.join(' / ')} )"
      end
    end
  end
end
