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

  # == Relationships ========================================================

  # == Validations ==========================================================

  validates :key, presence: true
  validates :key, uniqueness: true

  # == Scopes ===============================================================

  scope :by_key, -> (key) { where(key: key) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  def self.get(key)
    setting = self.by_key(key).first

    return case
      when setting.nil?
        raise "Setting with key #{key} was not found."
      when setting.reference? || setting.image?
        setting.load_reference
      when setting.boolean?
        setting.value == "1"
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

  def boolean?
    data_type == "boolean"
  end

  def to_s
    case
    when boolean?
      value == "1" ? "True" : "False"
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
