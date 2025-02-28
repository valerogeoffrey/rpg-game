# frozen_string_literal: true

module Enigmas
  module Strategies
    class Free < Base
      def question
        "#{enigma.question} free response"
      end
    end
  end
end
