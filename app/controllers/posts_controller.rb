class PostsController < ApplicationController
  # index以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:index]

  def index
    @profile = Profile.find(params[:id])
    @posts = @profile.posts
    @post = Post.new
  end

  def create
    @profile = Profile.find(params[:id])
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

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を修正しました。"
      redirect_to timeline_profile_path(@post.profile.id)
    else
      flash[:error] = "投稿の修正に失敗しました。"
      redirect_to timeline_profile_path(@post.profile.id)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @profile = @post.profile
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to timeline_profile_path(@profile)
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end

end
