class ProfilesController < ApplicationController
  # show、search以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: %i[show search]
  # プロフィールの特定
  before_action :set_profile, except: %i[new create index search]

  # プロフィールページ
  def show
    @link = Link.new
    @comment = Comment.new
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # プロフィール作成フォーム
  def new
    @profile = Profile.new
    @color = Color.new
  end

  # プロフィールを新規作成
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @color = Color.new(color_params)
    @color.profile_id = @profile.id
    if @profile.save && @color.save
      flash[:notice] = 'プロフィールを新規作成しました。'
      redirect_to mypage_path
    else
      render 'new'
    end
  end

  # プロフィール編集フォーム
  def edit
    # プロフィールオーナー=ログインユーザーの場合
    if @profile.user == current_user
      @color = @profile.color
      render 'edit'
    # プロフィールオーナー≠ログインユーザーの場合
    else
      redirect_to root_path
    end
  end

  # プロフィールへの編集を保存
  def update
    if @profile.update(profile_params) && @color.update(color_params)
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

  # プロフィールの特定
  def set_profile
    @profile = Profile.find_by(code: params[:code])
  end

  private

  def profile_params
    params.require(:profile).permit(:code, :name, :image, :introduction, :status)
  end

  def color_params
    params.require(:color).permit(:text, :background, :accent)
  end
end
