module InitSettings

  InitSetting = Struct.new(:key, :name, :data_type, :description) do
    def initialize(*)
      super
      self.data_type ||= 'string'
    end
  end

  def self.defaults
    [
      InitSetting.new(:title,        "Title", :string,
        "Main website title."),
      InitSetting.new(:short_desc,   "Short Description", :string,
        "Short description displayed on home page."),
      InitSetting.new(:footer,       "Footer", :code,
        "HTML which is used for the website footer."),
      InitSetting.new(:main_image,   "Main Image", :image,
        "Image used on home page."),
      InitSetting.new(:header_code,  "Header Code", :code,
        "Code that will be injected near the end of the head tag."),
      InitSetting.new(:footer_code,  "Footer Code", :code,
        "Code that will be injected just before the closing body tag."),
      InitSetting.new(:heading_font, "Heading Font", :string,
        "CSS Font-Family for the header tags (h1 - h6). Please ensure you've included the font file in the Header Code setting."),
      InitSetting.new(:body_font,    "Body Font", :string,
        "CSS Font-Family for the body (p) tags. Please ensure you've included the font file int he Header Code setting."),
      InitSetting.new(:social_share_code, "Social Share Code", :code,
        "Code that will be placed anywhere that social sharing is needed.")
    ]
  end

end