# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  name                            :string           not null
#  email                           :string           not null
#  linkedin                        :string
#  twitter                         :string
#  crypted_password                :string           not null
#  salt                            :string           not null
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  upload_id                       :integer
#  github                          :string
#

class User < ActiveRecord::Base

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  authenticates_with_sorcery!
  if ENV["I18N"]
    translates :snippet
  end

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
