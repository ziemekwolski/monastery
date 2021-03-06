class Upload < ActiveRecord::Base

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  has_attached_file :file, styles: {
    square_200:    "200x200#",
    square_800:    "800x800#",
    vertical_620:  "368x620#",
    wide_1440:     "1440x460#",
    square_1440:   "1440x1440#"
  }, convert_options: {
    square_200: "-quality 50 -strip",
    square_800: "-quality 50 -strip"
  }

  # == Relationships ========================================================

  # == Validations ==========================================================

  validates :file, presence: true
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  before_validation :set_default_name, on: :create

  # == Class Methods ========================================================

  class << self

    def image_url_for(id, style)
      Upload.find(id).file.url(style)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def reprocess_style(style, scope = nil)
      scope ||= Upload
      scope.find_each do |upload|
        upload.file.reprocess! style.to_sym
      end
    end

  end

  # == Instance Methods =====================================================

  def file_extension
    File.extname(self.file_file_name).gsub('.', '').downcase
  end

  def set_default_name
    if self.name.blank? || self.name == self.file_file_name
      self.name = self.file_file_name.to_s.gsub(".#{self.file_extension}", "").gsub("-", " ").humanize
    end
  end

end
