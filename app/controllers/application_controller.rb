class ApplicationController < ActionController::Base
  # ログイン後の遷移先を指定
  def after_sign_in_path_for(_resource)
    flash[:notice] = 'ログインしました。'
    mypage_path
  end
end
