# frozen_string_literal: true

module Livestorm
  class Displayer
    def self.hello_livestorm
      puts "
░▒▓█▓▒░░▒▓█▓▒░ ░▒▓████████▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░         ░▒▓██████▓▒░
░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░
░▒▓████████▓▒░ ░▒▓██████▓▒░   ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░ ░▒▓████████▓▒░ ░▒▓████████▓▒░ ░▒▓████████▓▒░  ░▒▓██████▓▒░
"
      puts "
░▒▓█▓▒░        ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓████████▓▒░  ░▒▓███████▓▒░ ░▒▓████████▓▒░  ░▒▓██████▓▒░  ░▒▓███████▓▒░  ░▒▓██████████████▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░           ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░  ░▒▓█▓▒▒▓█▓▒░  ░▒▓█▓▒░        ░▒▓█▓▒░           ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░  ░▒▓█▓▒▒▓█▓▒░  ░▒▓██████▓▒░    ░▒▓██████▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓███████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░   ░▒▓█▓▓█▓▒░   ░▒▓█▓▒░               ░▒▓█▓▒░    ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░   ░▒▓█▓▓█▓▒░   ░▒▓█▓▒░               ░▒▓█▓▒░    ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓████████▓▒░ ░▒▓█▓▒░    ░▒▓██▓▒░    ░▒▓████████▓▒░ ░▒▓███████▓▒░     ░▒▓█▓▒░      ░▒▓██████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
"
    end

    def self.welcome
      puts ''
      puts 'Welcome to the game !'
    end

    def self.description
      puts "
You are a brave hero entering a haunted castle.
Your goal is to find a way to escape while overcoming various obstacles and mysteries.
Be careful—every decision matters!
"
      puts ''
    end

    def self.exit_tips
      puts 'At any point, you can exit the game by typing "exit".'
      puts ''
    end

    def self.ask_for_go
      puts 'If you are ready to face this challenge, type "go" to begin.'
    end

    def self.ready_to_go
      puts 'Type "go" when you are ready.'
    end

    def self.ask_for_a_name
      puts 'what\'s the name of your hero ? '
    end

    def self.ask_for_a_difficulty
      puts 'What\'s difficulty do you want to play ? ( 1 - 3 )'
    end
  end
end
