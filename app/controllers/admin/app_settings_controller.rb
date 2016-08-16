class Admin::AppSettingsController < Admin::Base

  def edit
    @app_setting = AppSetting.instance
  end

  def update
    @app_setting = AppSetting.instance
    if @app_setting.update(app_setting_params)
      flash.notice = 'アプリケーション設定を更新しました。'
      redirect_to :admin_root
    else
      render action: 'edit'
    end
  end

  private

    def app_setting_params
      params.require(:app_setting).permit(:application_name, :session_timeout_in_min)
    end
end
