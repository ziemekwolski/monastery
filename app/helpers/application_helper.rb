module ApplicationHelper

  def parse_body(body)
    body = parse_posts(body)
    body = parse_categories(body)

    body = GitHub::Markdown.render_gfm(body)

    body.html_safe
  end

  def parse_posts(body)
    matches = body.scan(/(\[posts.*\])/)
    matches.each do |match|
      match_string = match.first.to_s

      posts = find_matched_posts(match_string.tr("[]", "<>"))
      result = render partial: "common/posts", locals: {posts: posts}

      body.sub!(match_string, result)
    end
    body
  end

  def find_matched_posts(match_string)
    doc = Nokogiri::Slop(match_string)

    scope = Post.published.static(false)

    if doc.posts.attributes.keys.include?("ids")
      scope = scope.where(id: doc.posts.attributes["ids"].to_s.split(","))
    end

    if doc.posts.attributes.keys.include?("categories")
      category_ids = Category.where(slug: doc.posts.attributes["categories"].to_s.split(",")).select(:id).map(&:id)
      scope = scope.where(category_id: category_ids)
    end

    scope.newest_first.limit(10)
  end

  def parse_categories(body)
    matches = body.scan(/(\[categories.*\])/)
    matches.each do |match|
      match_string = match.first.to_s

      categories = find_matched_categories(match_string.tr("[]", "<>"))
      result = render partial: "common/categories", locals: {categories: categories}

      body.sub!(match_string, result)
    end
    body
  end

  def find_matched_categories(match_string)
    doc = Nokogiri::Slop(match_string)

    scope = Category

    if doc.categories.attributes.keys.include?("ids")
      scope = scope.where(slug: doc.categories.attributes["ids"].to_s.split(","))
    end

    scope.limit(10)
  end


end
