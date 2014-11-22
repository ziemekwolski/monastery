class Language

  def self.native_name(code)
    code = code.to_s

    language = Monastery::LOCALES.find { |locale|
      locale["code"] == code
    }

    language.nil? ? code : language["nativeName"].split(",").first.strip
  end

end