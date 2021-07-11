# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # 退会ユーザーのブロック
  before_action :reject_user, only: [:create]

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # 退会ユーザーかどうか検証
  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      # 退会ユーザーのアドレスでパスワードが一致していた場合
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        redirect_to new_user_session_path
        flash[:error] = "退会済みです。"
      end
    # パスワードに誤りがあった場合
    else
      flash[:error] = "必須項目を入力してください。"
      redirect_to new_user_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
