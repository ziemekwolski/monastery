class PagesController < ApplicationController

  layout 'home'

  def home
    @categories = Category.listed
    @posts = Post.listed_posts.limit(10)
  end

end