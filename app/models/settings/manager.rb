module Settings
  module Manager
    extend self

    def setting_translatable?(key)
      setting = find_setting(key)
      setting["translatable"]
    end

    def load_default(key)
      setting = find_setting(key)
      setting["default"]
    end

    def find_setting(key)
      key = key.to_s
      setting = Monastery::SETTINGS.find {|setting|
        setting["key"] == key
      }
      raise "Setting with key #{key} was not found." if setting.nil?
      setting
    end

  end
end