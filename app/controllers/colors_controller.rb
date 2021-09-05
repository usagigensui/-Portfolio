class ColorsController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!
  # プロフィールの特定
  before_action :set_profile

  # カラーテーマの編集画面
  def edit; end

  # カラーテーマを編集を保存
  def update
    # デフォルトカラーに戻すにチェックがあった場合
    if params[:color][:default] == "true"
      if @profile.color.update(text: "#495057", background: "#ffffff", accent: "#a9a9a9")
        flash[:notice] = 'カラーテーマをデフォルトカラーに変更しました。'
      else
        flash[:error] = 'カラーテーマの編集に失敗しました。'
      end
    # デフォルトカラーに戻すにチェックがない場合
    else
      if @profile.color.update(color_params)
        flash[:notice] = 'カラーテーマを編集しました。'
      else
        flash[:error] = 'カラーテーマの編集に失敗しました。'
      end
    end
    redirect_to profile_path(@profile)
  end

  private

  def color_params
    params.require(:color).permit(:text, :background, :accent)
  end
end
