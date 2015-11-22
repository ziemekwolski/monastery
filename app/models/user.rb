class User < ActiveRecord::Base

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  authenticates_with_sorcery!

  # == Relationships ========================================================

  has_many :posts
  belongs_to :upload

  # == Validations ==========================================================

  validates :name, :email, presence: true
  validates :password, length: { minimum: 8 }, presence: true, on: :create
  validates :email, uniqueness: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  def self.for_select
    self.pluck(:name, :id)
  end

  # == Instance Methods =====================================================

  def to_param
    [self.id, self.name.to_s.parameterize].join("-")
  end

end
