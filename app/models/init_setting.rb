class InitSetting

  def self.load
    settings = YAML.load(File.open(Rails.root.join('config', 'settings.yml')))
    settings.each do |defaults|
      init_setting = new(defaults)
      init_setting.create_or_update!
    end
  end

  attr_accessor :defaults

  def initialize(defaults)
    self.defaults = defaults
  end

  def create_or_update!
    if Setting.by_key(defaults["key"]).exists?
      update_setting!
    else
      create_setting!
    end
  end

  def create_setting!
    Setting.create!({
      key: defaults["key"],
      name: defaults["name"],
      data_type: defaults["data_type"],
      description: defaults["description"],
      value: defaults["default"]
    })
  end

  def update_setting!
    setting = Setting.by_key(defaults["key"]).first
    setting.update!({
      name: defaults["name"],
      data_type: defaults["data_type"],
      description: defaults["description"]
    })
  end

end