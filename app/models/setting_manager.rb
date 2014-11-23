class SettingManager

  def self.setting_translatable?(key)
    key = key.to_s

    setting = Monastery::SETTINGS.find {|setting|
      setting["key"] == key
    }

    setting["translatable"]
  end

end