class UsersController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!

  # マイページ
  def show
    @user = current_user
  end

  # def edit
  #   @user = current_user
  # end

  # 退会確認
  def alert
    @user = current_user
  end

  #退会実行
  def withdraw
    @user = current_user
    # @user.update(is_valid: false)
    @user.update_attribute(:is_valid, false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
end
