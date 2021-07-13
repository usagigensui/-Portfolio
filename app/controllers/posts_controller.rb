class PostsController < ApplicationController
  # show以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:index]
  # プロフィールの特定
  before_action :set_profile

  def index
    @posts = @profile.posts
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.profile_id = @profile.id
    if @post.save
      flash[:notice] = "タイムラインへ投稿しました。"
      redirect_to timeline_profile_path(params[:id])
    else
      flash[:error] = "タイムラインへの投稿に失敗しました。"
      redirect_to timeline_profile_path(params[:id])
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

   # プロフィールの特定
  def set_profile
    @profile = Profile.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end

end
