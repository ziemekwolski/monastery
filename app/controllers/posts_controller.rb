class PostsController < ApplicationController

  layout 'post'
  before_action :load_post, only: [:show]

  def index

  end

  def show
    render @post.is_static? ? "static" : "show"
  end

  protected

  def load_post
    scope = logged_in? ? Post.published : Post
    @post = scope.where(slug: params[:id]).first || scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

end