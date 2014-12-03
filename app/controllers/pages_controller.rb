class PagesController < ApplicationController

  layout 'home'

  def home
    @categories = Category.listed

    scope = Post.listed_posts
    if Setting.get(:i18n_activated)
      scope = scope.with_translations(I18n.locale)
    end

    @posts_limit = 15
    @posts = scope.limit(@posts_limit)
    @posts_count = scope.count
  end

  def robots
    render layout: false
  end

end