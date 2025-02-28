# frozen_string_literal: true

module Characters
  class Character
    attr_reader :attacks
    attr_accessor :name, :points

    def initialize(attrs)
      attrs.each do |name, value|
        instance_variable_set(:"@#{name}", value)
      end
    end

    def attack(target, attack)
      catch(:game_event) do
        can_attack?(attack)

        left_points = target.points - point_for(attack)
        target.points = [left_points, 0].max

        return true
      end
    end

    private

    def can_attack?(attack)
      throw :game_event, :player_attack_unknown unless attack_available?(attack)
      throw :game_event, :player_dead if dead?

      true
    end

    def attack_available?(attack)
      attacks.keys.map(&:to_sym).include? attack.to_sym
    end

    def point_for(attack_name)
      return :unknow_attack unless attack_available?(attack_name)

      attacks.fetch(attack_name.to_sym)
    end

    def dead?
      points <= 0
    end
  end
end
