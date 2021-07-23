class UsersController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!

  # マイページ
  def mypage
    @user = current_user
  end

  # def edit
  #   @user = current_user
  # end

  # 退会確認
  def alert
    @user = current_user
  end

  # 退会実行
  def withdraw
    @user = current_user
    if @user.update(is_valid: false)
      reset_session
      flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
      redirect_to root_path
    else
      flash[:error] = '退会処理に失敗しました。'
      redirect_to mypage_path
    end
  end
end
