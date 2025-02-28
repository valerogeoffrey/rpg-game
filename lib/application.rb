# frozen_string_literal: true

require_relative 'vendor/bootstrap'

def start!
  app.displayer.hello_livestorm
  app.displayer.welcome
  app.displayer.description
  app.displayer.exit_tips

  app.handle_go
  hero_name = app.init_hero
  difficulty = app.init_difficulty

  # See app_conf.yml game section for available configs
  # ----------------------------------------------------
  Game.configure do |config|
    config.difficulty   = difficulty.to_i
    config.with_enigmas = true
    config.with_fights  = true
  end
  # ----------------------------------------------------

  Game.start(hero_name)
end
