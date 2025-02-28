# frozen_string_literal: true

module Fights::Strategies
  class OneVsOne < Base
    attr_reader :hero, :bot, :pov, :opponent

    def initialize(hero, bot)
      @hero = hero
      @bot = bot
    end

    def pov_on_hero
      @pov = hero
      set_opposant
    end

    def pov_on_enemy
      @pov = bot
      set_opposant
    end

    def prevent_no_fighters
      throw :game_event, :player_not_init if hero.nil? || bot.nil?
    end

    def prevent_dead_players
      prevent_dead_player
      prevent_dead_enemy
    end

    def prevent_dead_player
      throw :game_event, :player_dead if player_dead?
    end

    def prevent_dead_enemy
      throw :game_event, :player_opponent_dead if enemy_dead?
    end

    def player_dead?
      hero.points <= 0
    end

    def enemy_dead?
      bot.points <= 0
    end

    def attack_authorize?(attack)
      throw :game_event, :player_attack_not_auth if attack > pov.attacks.to_a.size
    end

    def choice_rand_attack
      (1..2).to_a.sample
    end

    def pov_attack(attack = nil)
      attack = choice_rand_attack if attack.nil?
      attack = attack_name(attack)
      pov.attack(opponent, attack)
      opponent
    end

    def attack_name(attack)
      attack = attack.to_i
      return :unknow_attack if attack > pov.attacks.to_a.size

      pov.attacks.to_a[attack - 1].first
    end

    private

    def set_opposant
      @opponent = pov == hero ? bot : hero
    end
  end
end
