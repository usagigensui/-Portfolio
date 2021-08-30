class FunctionSettingsController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!
  # プロフィールの特定
  before_action :set_profile

  def edit
  end

  # 機能の公開状況への編集を保存
  def update
    if @profile.function_setting.update(function_setting_params)
      flash[:notice] = '機能の公開状況を変更しました。'
    else
      flash[:error] = '機能の公開状況の変更に失敗しました。'
    end
    redirect_to profile_path(@profile)
  end

  private

  def function_setting_params
    params.require(:function_setting).permit(:timeline, :schedule, :gallery, :mail)
  end
end
