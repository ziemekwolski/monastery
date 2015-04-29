class PostsController < ApplicationController

  layout 'post'
  before_action :load_post, only: [:show]

  def index
    @posts = posts_scope.paginate(page: params[:page])

    render layout: 'other'
  end

  def show
    unless @post.is_static?
      @other_posts = posts_scope.where("posts.id != ?", @post.id)
    end
    render @post.is_static? ? "static" : "show"
  end

  protected

  def post_scope
    logged_in? ? Post : Post.published
  end

  def posts_scope
    scope = Post.listed_posts
    if Setting.get(:i18n_activated)
      scope = scope.with_translations(I18n.locale)
    end
    scope
  end

  def load_post
    @post = post_scope.where(slug: params[:id]).first || post_scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    try_redirect
  end

  def try_redirect
    redirect = Redirect.find_by!(from_slug: params[:id])
    redirect_to post_path(redirect.redirectable), status: :moved_permanently
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

end