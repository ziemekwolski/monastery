class Admin::UploadsController < Admin::BaseController
  skip_before_filter :verify_authenticity_token
  before_action :set_upload, only: [:edit, :update, :show]

  # GET /admin/uploads
  def index
    @uploads = Upload.paginate(page: params[:page])
    respond_to do |format|
      format.json {
        render json: @uploads, meta: {
          pagination: {
            page: @uploads.current_page,
            total: @uploads.total_entries
          }
        }
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
