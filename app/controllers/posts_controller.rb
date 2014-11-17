class PostsController < ApplicationController

  layout 'post'
  before_action :load_post, only: [:show]

  def index
  end

  def show
    load_other_posts unless @post.is_static?

    render @post.is_static? ? "static" : "show"
  end

  protected

  def load_other_posts
    @other_posts = Post.listed_posts.where("id != ?", @post.id).limit(2)
  end

  def load_post
    scope = logged_in? ? Post : Post.published
    @post = scope.where(slug: params[:id]).first || scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

end