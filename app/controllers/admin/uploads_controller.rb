class Admin::UploadsController < Admin::BaseController
  skip_before_filter :verify_authenticity_token
  before_action :set_upload, only: [:edit, :update, :show]

  # GET /admin/uploads
  def index
    scope = Upload

    if params[:term].present?
      scope = scope.where("uploads.name ilike ?", "%#{params[:term]}%")
    end

    @uploads = scope.paginate(page: params[:page])
    respond_to do |format|
      format.json {

        next_url = if @uploads.current_page < @uploads.total_pages
          admin_uploads_url(format: :json, term: params[:term], page: @uploads.current_page + 1)
        else
          ""
        end

        previous_url = if @uploads.current_page > 1
          admin_uploads_url(format: :json, term: params[:term], page: @uploads.current_page - 1)
        else
          ""
        end

        response.headers["X-Pagination-Page"]     = @uploads.current_page.to_s
        response.headers["X-Pagination-Total"]    = @uploads.total_pages.to_s
        response.headers["X-Pagination-Per-Page"] = @uploads.per_page.to_s
        response.headers["X-Pagination-Next"]     = next_url
        response.headers["X-Pagination-Previous"] = previous_url

        render json: @uploads
      }
    end
  end

  # GET /admin/uploads/1
  def show
    respond_to do |format|
      format.json { render json: @upload }
    end
  end

  # POST /admin/uploads
  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      format.json {
        if @upload.save
          render json: @upload
        else
          render json: @upload, meta: {errors: @upload.errors.messages}, status: 400
        end
      }
    end
  end

  # PATCH/PUT /admin/uploads/1
  def update
    respond_to do |format|
      format.json {
        if @upload.update(upload_params)
          render json: @upload
        else
          render json: @upload, meta: {errors: @upload.errors.messages}, status: 400
        end
      }
    end
  end

  private

    def set_upload
      @upload = Upload.find(params[:id])
    end

    def upload_params
      params.require(:upload).permit(:name, :file)
    end
end
