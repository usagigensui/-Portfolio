class ProfilesController < ApplicationController
  # show以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:show]

  # プロフィールページ
  def show
    @profile = Profile.find(params[:id])
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
    @profile = Profile.find(params[:id])
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
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to mypage_path
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
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to mypage_path
  end

  private

  def profile_params
    params.require(:profile).permit(:code, :name, :image, :introduction)
  end
end
