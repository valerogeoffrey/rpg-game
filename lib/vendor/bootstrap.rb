# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'singleton'
require 'pathname'
require 'ostruct'
require 'yaml'
require 'pry'
require 'erb'

require_relative 'config/app_conf'
require_relative 'livestorm/displayer'
require_relative 'livestorm/command'
require_relative 'utils'
require_relative 'base_builder'
require_relative 'base_command'

require_relative 'game'
require_relative 'game/container'
require_relative 'game/configuration'
require_relative 'game/displayer'
require_relative 'game/command'
require_relative 'game/builder'
require_relative 'game/cursor'
require_relative 'game/strategy'

require_relative 'rooms/builder'
require_relative 'rooms/room'

require_relative 'characters/character'
require_relative 'characters/hero'
require_relative 'characters/builder'

require_relative 'enigmas/strategies/base'
require_relative 'enigmas/strategies/free'
require_relative 'enigmas/strategies/with_choice'
require_relative 'enigmas/displayer'
require_relative 'enigmas/builder'
require_relative 'enigmas/command'
require_relative 'enigmas/enigma'

require_relative 'fights/command'
require_relative 'fights/displayers/base'
require_relative 'fights/strategies/base'
require_relative 'fights/displayers/wizard'
require_relative 'fights/strategies/one_vs_one'
