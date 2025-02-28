# frozen_string_literal: true

ROOT_PATH = Pathname.new(__FILE__).dirname.dirname.dirname
APP_CONF = begin
  config_path = ROOT_PATH.join('vendor', 'config', 'app_conf.yml')

  yaml_content = File.read(config_path)
  parsed_yaml = YAML.safe_load(ERB.new(yaml_content).result(binding), aliases: true, permitted_classes: [Symbol, Time])

  ActiveSupport::HashWithIndifferentAccess.new(parsed_yaml)
rescue Errno::ENOENT
  pp 'Missing configuration file'
  exit
end
