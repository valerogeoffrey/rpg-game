# frozen_string_literal: true

module Fights
  class Command < BaseCommand
    attr_reader :strategy, :displayer

    def initialize(strategy, displayer)
      @strategy = strategy
      @displayer = displayer
    end

    def play
      loop do
        msg = catch(:game_event) { execute_turn }

        return :finished if handle_message(msg)
      end
    end

    private

    def execute_turn
      strategy.prevent_no_fighters
      strategy.prevent_dead_players

      hero_attack
      opponent_attack
    end

    def handle_message(msg)
      case msg
      when :player_attack_not_auth
        displayer.attack_issue
        opponent_attack
        false
      when :player_opponent_dead
        displayer.enemy_is_dead
        true
      when :player_dead
        displayer.player_is_dead
        true
      when :player_not_init
        true
      else
        false
      end
    end

    def hero_attack
      strategy.pov_on_hero
      displayer.attacks_choice(strategy.pov)
      attack = fetch_attack

      throw :game_error, :force_exit if attack == 'exit'

      attack = attack.to_i
      strategy.attack_authorize?(attack)

      attack_response = strategy.pov_attack(attack)
      attack_name = strategy.attack_name(attack)

      displayer.attack_congrats(attack_response, attack_name)
    end

    def opponent_attack
      strategy.pov_on_enemy
      strategy.prevent_dead_players
      attack_response = strategy.pov_attack
      displayer.enemy_attack(attack_response)
    end

    def attack_name(attack)
      player_one.attacks.to_a[attack - 1].first
    end

    def fetch_attack
      attack = gets
      attack ||= ''
      attack.chomp
    end
  end
end
