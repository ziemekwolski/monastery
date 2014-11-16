SitemapGenerator::Sitemap.default_host = ENV['SITE_HOST']
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

SitemapGenerator::Sitemap.create do

  Post.listed_posts.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end

  add categories_path
  Category.listed.find_each do |category|
    add category_path(category)
  end

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
