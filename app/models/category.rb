class Category < ActiveRecord::Base

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================

  has_many :posts
  belongs_to :upload

  # == Validations ==========================================================

  validates :name, :description, :slug, presence: true
  validates :slug, uniqueness: true

  # == Scopes ===============================================================

  scope :listed, -> (show_listed = true) { where(is_listed: show_listed) }

  # == Callbacks ============================================================

  before_validation :set_slug

  # == Class Methods ========================================================

  def self.for_select
    self.pluck(:name, :id)
  end

  # == Instance Methods =====================================================

  def to_param
    self.slug
  end

  protected

  def set_slug
    self.slug = self.name.to_s.parameterize if self.slug.blank?
  end

end
