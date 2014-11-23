class SettingManager

  def self.setting_translatable?(key)
    setting = self.find_setting(key)
    setting["translatable"]
  end

  def self.load_default(key)
    setting = self.find_setting(key)
    setting["default"]
  end

  def self.find_setting(key)
    key = key.to_s
    setting = Monastery::SETTINGS.find {|setting|
      setting["key"] == key
    }
    raise "Setting with key #{key} was not found." if setting.nil?
    setting
  end

end