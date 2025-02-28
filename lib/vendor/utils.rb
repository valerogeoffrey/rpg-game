# frozen_string_literal: true

def fetch_console(type = :string)
  case type
  when :integer then $stdin.gets.chomp.to_i
  when :sym then $stdin.gets.chomp.to_sym
  else
    $stdin.gets.chomp
  end
end

def hero_instance
  Characters::Hero.instance
end

def game_displayer
  @game_displayer ||= Game::Displayer.new
end

def app
  @app ||= Livestorm::Command.new
end
