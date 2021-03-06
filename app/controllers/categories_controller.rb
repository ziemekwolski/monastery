class CategoriesController < ApplicationController

  layout 'other'
  before_action :load_category, only: [:show]

  def index
    @categories = Category.listed
  end

  def show
    scope = @category.posts.listed_posts
    @posts = scope.paginate(page: params[:page])
    @other_categories = Category.listed.where("categories.id != ?", @category.id)
  end

  protected

  def load_category
    @category = Category.find_by(slug: params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

end