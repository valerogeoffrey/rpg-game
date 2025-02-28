# frozen_string_literal: true

module Fights::Displayers
  class Wizard < Base
    def attacks_choice(player)
      puts "> #{player.name} what spell do you want to use ?"
      player.attacks.keys.each_with_index do |attack, index|
        puts "#{index + 1} - #{attack}"
      end
      puts ''
      puts "> You'r choice ? "
    end

    def attack_congrats(player, attack)
      puts ''
      puts '# ---------------------------------------------------------------#'
      puts "# > You use the spell #{attack} Impressive ! #{player.name} has #{player.points} points left"
    end
  end
end
