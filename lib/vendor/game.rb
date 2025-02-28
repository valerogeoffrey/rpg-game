# frozen_string_literal: true

module Game
  def self.configuration
    @@configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.start(hero_name)
    hero_instance.name = hero_name

    container = Container.new
    game = Game::Builder.call(container, options: { configuration: configuration })

    game_strategy = game.strategy
    Game::Command.new(game_strategy).play
  end
end
