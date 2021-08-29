class ApplicationController < ActionController::Base
  # ログイン後の遷移先を指定
  def after_sign_in_path_for(_resource)
    flash[:notice] = 'ログインしました。'
    mypage_path
  end

  # 機能の種別確認
  FUNCTIONS = {
    'profiles' => 'profiles',
    'posts' => 'timeline',
    'schedules' => 'schedule',
    'images' => 'gallery',
    'inquiries' => 'mail'
  }.freeze

  # 非公開プロフィール・機能へのアクセスをブロック
  def function_release_check(profile)
    if FUNCTIONS[controller_path] == 'profiles'
      nil
    elsif profile.function_setting.public_send(FUNCTIONS[controller_path])
      nil
    else
      flash[:error] = '非公開のページです。'
      redirect_to root_path
    end
  end

  def release_check(profile)
    if profile.status == '公開'
      function_release_check(profile)
    elsif profile.user == current_user
      function_release_check(profile)
    else
      flash[:error] = '非公開のページです。'
      redirect_to root_path
    end
  end

  # プロフィールの特定、プロフィールオーナー==ログインユーザーかを確認
  def set_profile
    @profile = Profile.find_by(code: params[:code])
    return unless current_user.id != @profile.user_id

    flash[:error] = '不正な操作です。'
    redirect_to root_path
  end
end
