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

SitemapGenerator::Sitemap.create do

  # Posts
  Post.listed_posts.find_each do |post|
    add(post_path(post), lastmod: post.updated_at)
  end

  # Categories Index
  add(categories_path)

  # Categories
  Category.listed.find_each do |category|
    add(category_path(category))
  end

end