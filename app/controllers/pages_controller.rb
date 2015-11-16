class PagesController < ApplicationController

  layout 'other'

  def home
    @categories = Category.listed

    scope = Post.listed_posts

    @posts_limit = 15
    @posts = scope.limit(@posts_limit)
    @posts_count = scope.count
  end

  def robots
    render layout: false
  end

end