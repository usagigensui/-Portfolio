class ColorsController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!
  # プロフィールの特定
  before_action :set_profile

  # カラーテーマの編集画面
  def edit; end

  # カラーテーマを編集を保存
  def update
    if @profile.color.update(color_params)
      flash[:notice] = 'カラーテーマを編集しました。'
    else
      flash[:error] = 'カラーテーマの編集に失敗しました。'
    end
    redirect_to profile_path(@profile)
  end

  private

  def color_params
    params.require(:color).permit(:text, :background, :accent)
  end
end
