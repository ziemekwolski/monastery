atom_feed({'xmlns:app' => 'http://www.w3.org/2007/app',
    'xmlns:openSearch' => 'http://a9.com/-/spec/opensearch/1.1/',
    'xml:lang' => I18n.locale.to_s}) do |feed|
  feed.title(Setting.get(:title) + " - " + (@category.nil? ? I18n.t('posts') : @category.name))
  feed.subtitle(@category.nil? ? Setting.get(:short_desc) : @category.description)
  feed.updated((@posts.first.published_at))
  feed.tag!('openSearch:totalResults', @posts.size)

  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.summary, type: 'html')
      entry.tag!('app:edited', post.published_at)

      entry.author do |author|
        author.name(post.user.name)
      end
    end
  end
end