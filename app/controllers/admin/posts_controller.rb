class Admin::PostsController < Admin::BaseController
  before_action :set_admin_post, only: [:show, :edit, :update, :destroy]

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    params[:q] ||= {s: "published_at desc"}

    @search = Post.includes(:user, :category).search(params[:q])
    @posts = @search.result.paginate(page: params[:page])
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @post = Post.new(admin_post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_admin_post_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    respond_to do |format|

      old_slug = @post.slug

      if @post.update(admin_post_params)

        unless old_slug == @post.slug
          Redirect.create!({
            from_slug: old_slug,
            redirectable: @post
          })
        end

        format.html { redirect_to edit_admin_post_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_post
      @post = Post.where(slug: params[:id]).first || Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_post_params
      params.require(:post).permit(
        :slug, :title, :subtitle, :body, :user_id, :category_id, :is_static,
        :source_url, :source_name, :seo_description, :published,
        :upload_id, :summary, :is_listed, :seo_tags
      )
    end
end
