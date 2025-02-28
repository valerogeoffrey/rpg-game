# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'APP_CONF' do
  let(:parsed_yaml) do
    YAML.safe_load(ERB.new(yaml_content).result(binding), aliases: true, permitted_classes: [Symbol, Time])
  end
  let(:config_path) { ROOT_PATH.join('vendor', 'config', 'app_conf.yml') }
  let(:yaml_content) do
    <<~YAML
      development:
        hero:
          name: "Buzz"
          points: 100
          attacks:
            expeliarmus: 65
            Destructum: 80
            Flipendo: 58
    YAML
  end

  before { stub_const('APP_CONF', ActiveSupport::HashWithIndifferentAccess.new(parsed_yaml)) }

  it 'parses YAML content correctly' do
    expect(APP_CONF[:development][:hero][:name]).to eq('Buzz')
    expect(APP_CONF[:development][:hero][:points]).to eq(100)
  end

  it 'converts the parsed YAML to a HashWithIndifferentAccess' do
    expect(APP_CONF).to be_a(ActiveSupport::HashWithIndifferentAccess)
    expect(APP_CONF['development']['hero']['name']).to eq('Buzz') # Accès avec des strings
    expect(APP_CONF[:development][:hero][:name]).to eq('Buzz')    # Accès avec des symbols
  end
end
