class FeedsController < ApplicationController

  layout false

  def index
    scope = build_scope
    @posts = scope.limit(50)
  end

  private

  def build_scope
    scope = if params[:category_id]
      @category = Category.find_by(slug: params[:category_id])
      @category.posts
    else
      Post
    end
    scope.listed_posts
  rescue ActiveRecord::RecordNotFound
    redirect_to feeds_url(format: :xml)
  end

end