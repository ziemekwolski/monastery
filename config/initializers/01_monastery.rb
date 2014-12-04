module Monastery

  LOCALES = YAML.load(File.open(Rails.root.join('config', 'locales.yml')))
  SETTINGS = YAML.load(File.open(Rails.root.join('config', 'settings.yml')))

end