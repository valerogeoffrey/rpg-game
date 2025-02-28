# frozen_string_literal: true

module Game
  class Displayer
    def ask_for_moove(moove)
      puts ">> Which way do you want to go? ( #{moove} )"
    end

    def room_position(position)
      puts ''
      puts '> ---- > Moove silently > -------------- >'
      puts "> You are in the room ## #{position} ##"
    end

    def you_are_out(reason)
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      case reason
      when :end, nil
        puts "> You'r out of this darkness hunted castle"
      when :force_exit
        puts '> Bye ! See you soon hope !'
      when :player_dead
        puts '> You have been killed :(, but you can try again !'
      end
    end

    def invalid_moove
      puts '/!\ sorry you can\'t go in this direction /!\\'
      puts ''
    end

    def emergency_exit
      puts '> You find an emergency exit ! =) '
    end

    def bye
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      puts 'Bye ! See you soon !'
    end
  end
end
