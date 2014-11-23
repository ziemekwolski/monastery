module Monastery
end

Monastery::LOCALES = YAML.load(File.open(Rails.root.join('config', 'locales.yml')))
Monastery::SETTINGS = YAML.load(File.open(Rails.root.join('config', 'settings.yml')))