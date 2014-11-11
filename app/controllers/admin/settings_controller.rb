class Admin::SettingsController < Admin::BaseController

  before_action :set_setting, only: [:edit, :update]

  # GET /admin/settings
  # GET /admin/settings.json
  def index
    params[:q] ||= {}

    @search = Setting.search(params[:q])
    @settings = @search.result.paginate(page: params[:page])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @setting.update(admin_setting_params)
        format.html { redirect_to admin_settings_path, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_setting
    @setting = Setting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_setting_params
    params.require(:setting).permit(:key, :value)
  end

end