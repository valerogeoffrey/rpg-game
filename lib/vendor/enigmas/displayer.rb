# frozen_string_literal: true

module Enigmas
  class Displayer
    def ask_question(question)
      puts question.strip
    end

    def congratulation
      puts "> Congratulation, you'r right ! "
      puts ''
    end

    def excedded_try
      puts '> you have reach the response limit :( '
    end

    def introduction
      puts "> Before you can gout out of ths rooms, you'll have to solve a little riddle"
    end

    def try_again(try_left)
      puts "> it's not correct ! you still have #{try_left} try "
    end
  end
end
