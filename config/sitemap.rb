default_host = ENV['SITE_HOST']
SitemapGenerator::Sitemap.default_host = default_host
SitemapGenerator::Sitemap.public_path = 'tmp/'

unless Rails.env.development? || Rails.env.test?
  SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/"
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new({
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    fog_provider:          "AWS",
    fog_directory:         ENV['S3_BUCKET_NAME']
  })
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
end

alternate_locales = if Setting.get(:i18n_activated)
  Idioma.conf.locales - Array(Idioma.conf.default_locale)
else
  []
end

SitemapGenerator::Sitemap.create do

  # Posts
  Post.listed_posts.find_each do |post|
    alternates = alternate_locales.map do |locale|
      {
        href: post_url(post, locale: locale, host: default_host),
        lang: locale
      }
    end
    add(post_path(post, locale: nil),
      lastmod: post.updated_at,
      alternates: alternates
    )
  end

  # Categories Index
  alternates = alternate_locales.map do |locale|
    {
      href: categories_url(locale: locale, host: default_host),
      lang: locale
    }
  end
  add(categories_path(locale: nil), alternates: alternates)

  # Categories
  Category.listed.find_each do |category|
    alternates = alternate_locales.map do |locale|
      {
        href: category_url(category, locale: locale, host: default_host),
        lang: locale
      }
    end
    add(category_path(category, locale: nil), alternates: alternates)
  end

end