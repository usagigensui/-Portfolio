class ProfilesController < ApplicationController
  # show以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:show]
  # プロフィールの特定
  before_action :set_profile, except: [:new, :create, :index]

  # プロフィールページ
  def show
    @link = Link.new
    @comment = Comment.new
  end

  # プロフィール作成フォーム
  def new
    @profile = Profile.new
  end

  # プロフィールを新規作成
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to mypage_path
    else
      render 'new'
    end
  end

  # プロフィール編集フォーム
  def edit
    # プロフィールオーナー=ログインユーザーの場合
    if @profile.user == current_user
      render "edit"
    # プロフィールオーナー≠ログインユーザーの場合
    else
      redirect_to root_path
    end
  end

  # プロフィールへの編集を保存
  def update
    if @profile.update(profile_params)
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
    redirect_to mypage_path
  end

   # プロフィールの特定
  def set_profile
    @profile = Profile.find_by(code: params[:code])
  end

  private

  def profile_params
    params.require(:profile).permit(:code, :name, :image, :introduction)
  end
end
