class ProfilesController < ApplicationController
  # show、search以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: %i[show search]
  # 操作ユーザーの確認
  before_action :set_profile, only: %i[edit status update destroy]

  # プロフィールページ
  def show
    @profile = Profile.find_by(code: params[:code])
    @comment = Comment.new
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # プロフィール作成フォーム
  def new
    @profile = Profile.new
    @profile.build_function_setting
  end

  # プロフィールを新規作成
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      @color = Color.create(profile_id: @profile.id)
      flash[:notice] = 'プロフィールを新規作成しました。'
      redirect_to mypage_path
    else
      render 'new'
    end
  end

  # プロフィール編集フォーム
  def edit; end

  # 公開設定編集ページ
  def status; end

  # プロフィールへの編集を保存
  def update
    if @profile.update(profile_params)
      flash[:notice] = 'プロフィールを編集しました。'
      redirect_to profile_path(@profile)
    else
      render 'edit'
    end
  end

  # プロフィール一覧(削除ページ)
  def index
    @profiles = current_user.profiles
  end

  # プロフィールを削除
  def destroy
    @profile.destroy
    flash[:notice] = 'プロフィールを削除しました。'
    redirect_to mypage_path
  end

  # ユーザー検索
  def search
    @profiles = Profile.search(params[:keyword])
    @keyword = params[:keyword]
  end

  private

  def profile_params
    params.require(:profile).permit(:code, :name, :image, :introduction, :status,
                                    function_setting_attributes: %i[id timeline schedule gallery mail]).merge(user_id: current_user.id)
  end
end
