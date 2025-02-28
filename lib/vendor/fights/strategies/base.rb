# frozen_string_literal: true

module Fights::Strategies
  class Base
    def prevent_dead_players
      raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
    end

    def player_dead?
      raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
    end

    def enemy_dead?
      raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
    end

    def attack_authorize?(_)
      raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
    end

    def choice_rand_attack
      raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
    end

    def attack_name(*_args)
      raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
    end
  end
end
