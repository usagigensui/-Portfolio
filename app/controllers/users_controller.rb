class UsersController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!
  # ゲストユーザーの削除禁止
  before_action :ensure_guest_user, only: %i[alert withdraw]

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

  # ゲストユーザーの削除禁止
  def ensure_guest_user
    @user = current_user
    return unless @user.email == 'guest@example.com'

    flash[:error] = 'ゲストユーザーは退会できません。'
    redirect_to mypage_path
  end
end
