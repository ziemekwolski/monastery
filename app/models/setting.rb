# == Schema Information
#
# Table name: settings
#
#  id          :integer          not null, primary key
#  key         :string
#  value       :text
#  created_at  :datetime
#  updated_at  :datetime
#  data_type   :string           default("string")
#  name        :string
#  description :text
#

class Setting < ActiveRecord::Base

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  translates :value

  # == Relationships ========================================================

  # == Validations ==========================================================

  validates :key, presence: true
  validates :key, uniqueness: true

  # == Scopes ===============================================================

  scope :by_key, -> (key) { where(key: key) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  def self.get(key)
    return self.i18n_default_locale if key == :i18n_default_locale
    self.translated_get(key)
  end

  def self.translated_get(key)
    locale = SettingManager.setting_translatable?(key) ? I18n.locale : Setting.get(:i18n_default_locale)

    Globalize.with_locale(locale) do
      setting = self.by_key(key).first
      return case
        when setting.nil?
          SettingManager.load_default(key)
        when setting.reference? || setting.image?
          setting.load_reference
        when setting.boolean?
          setting.value == "1"
        else
          setting.value.to_s
      end
    end
  end

  # This is a way to find the default locale without going through
  # the normal Globalize way of looking it up.
  def self.i18n_default_locale
    self.where(key: :i18n_default_locale).pluck(:value).first
  end

  def self.key_from_id(id)
    self.where(id: id).pluck(:key).first
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

  def boolean?
    data_type == "boolean"
  end

  def to_s
    case
    when boolean?
      value == "1" ? I18n.t('admin.ans_yes') : I18n.t('admin.ans_no')
    else
      value.to_s
    end
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
