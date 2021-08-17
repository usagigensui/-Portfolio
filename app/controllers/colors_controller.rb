class ColorsController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!

  # カラーテーマの編集画面
  def edit
    @profile = Profile.find_by(code: params[:code])
    # プロフィールオーナー=ログインユーザーの場合
    if @profile.user == current_user
      render 'edit'
    # プロフィールオーナー≠ログインユーザーの場合
    else
      redirect_to root_path
    end
  end

  # カラーテーマを編集を保存
  def update
    @profile = Profile.find_by(code: params[:code])
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
