class PagesController < ApplicationController

  layout 'home'

  def home
    @categories = Category.listed

    scope = Post.listed_posts
    if Setting.get(:i18n_activated)
      scope = scope.with_translations(I18n.locale)
    end
    @posts = scope.limit(10)
  end

  def robots
    render layout: false
  end

end