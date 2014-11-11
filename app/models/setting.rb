# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  key        :string
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#  data_type  :string           default("string")
#  name       :string
#

class Setting < ActiveRecord::Base

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  validates :key, presence: true
  validates :key, uniqueness: true

  # == Scopes ===============================================================

  scope :by_key, -> (key) { where(key: key) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  def self.init_settings
    InitSettings.defaults.each do |init_setting|
      unless self.by_key(init_setting.key).exists?
        self.create!({
          key: init_setting.key,
          name: init_setting.name,
          data_type: init_setting.data_type,
          description: init_setting.description
        })
      end
    end
  end

  def self.get(key)
    setting = self.by_key(key).first

    return case
      when setting.nil?
        raise "Setting with key #{key} was not found."
      when setting.reference? || setting.image?
        setting.load_reference
      else
        setting.value.to_s
    end
  end

  # == Instance Methods =====================================================

  def string?
    data_type == "string"
  end

  def text?
    data_type == "text"
  end

  def reference?
    data_type == "reference"
  end

  def code?
    data_type == "code"
  end

  def image?
    data_type == "image"
  end

  def load_reference
    return nil unless value.present?
    (ref_class, ref_id) = value.split(",")
    ref_class.constantize.find(ref_id)
  end

  def load_image
    load_reference
  end

end
