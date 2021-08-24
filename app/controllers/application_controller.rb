class ApplicationController < ActionController::Base
  # ログイン後の遷移先を指定
  def after_sign_in_path_for(_resource)
    flash[:notice] = 'ログインしました。'
    mypage_path
  end

  # 非公開プロフィールへのアクセスをブロック
  def release_check(profile)
    return unless profile.status == '非公開' && profile.user != current_user

    flash[:error] = '非公開のプロフィールです。'
    redirect_to root_path
  end

  # プロフィールの特定、プロフィールオーナー==ログインユーザーかを確認
  def set_profile
    @profile = Profile.find_by(code: params[:code])
    return unless current_user.id != @profile.user_id

    flash[:error] = '不正な操作です。'
    redirect_to root_path
  end
end
