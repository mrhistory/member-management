# Loads the settings from the settings file.

APP_CONFIG = HashWithIndifferentAccess.new(YAML.load(ERB.new(File.read(Rails.root.join("config","settings.yml"))).result)[Rails.env])