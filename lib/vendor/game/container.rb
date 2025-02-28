# frozen_string_literal: true

module Game
  class Container
    attr_reader :dependencies

    def initialize(config = {})
      @config = config
    end

    def resolve(dependency)
      dependencies[dependency]
    end

    def dependencies # rubocop:disable Lint/DuplicateMethods
      @dependencies ||=
        {
          game_displayer: Game::Displayer.new,
          enigma_displayer: Enigmas::Displayer.new,
          fight_displayer: Fights::Displayers::Wizard.new,
          fight_strategy: Fights::Strategies::OneVsOne,
          game_strategy: Game::Strategy,
          game_cursor: Game::Cursor,
          fight_command: Fights::Command
        }
    end

    # if we want add more flexibility and more behavior
    # we could consider implement a register method to swap dependencies
  end
end
