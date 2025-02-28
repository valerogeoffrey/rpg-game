# frozen_string_literal: true

# spec/vendor/game/configuration_spec.rb

require 'spec_helper'

RSpec.describe Game::Configuration do
  let(:app_conf_game) { APP_CONF[:game] }
  let(:config) { described_class.new }

  before do
    allow(APP_CONF).to receive(:[]).with(:game).and_return(app_conf_game)
  end

  it 'initializes with the correct attributes from APP_CONF[:game]' do
    app_conf_game.each do |key, value|
      expect(config.public_send(key)).to eq(value)
    end
  end

  it 'creates an accessor for each key in APP_CONF[:game]' do
    app_conf_game.each_key do |key|
      expect(config).to respond_to(key)
      expect(config).to respond_to("#{key}=")
    end
  end

  it 'sets the correct values for the instance variables' do
    app_conf_game.each do |key, value|
      instance_var = "@#{key}"
      expect(config.instance_variable_get(instance_var)).to eq(value)
    end
  end
end
