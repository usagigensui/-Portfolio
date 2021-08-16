class PostsController < ApplicationController
  # index以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:index]

  # タイムライン
  def index
    @profile = Profile.find_by(code: params[:code])
    @posts = @profile.posts.page(params[:page]).per(10).reverse_order
    @post = Post.new
    @link = Link.new
    ## 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # 新規投稿
  def create
    @profile = Profile.find_by(code: params[:code])
    @post = Post.new(post_params)
    @post.profile_id = @profile.id
    if @post.save
      flash[:notice] = 'タイムラインへ投稿しました。'
    else
      flash[:error] = 'タイムラインへの投稿に失敗しました。'
    end
    redirect_to timeline_profile_path(params[:code])
  end

  # 投稿を編集
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '投稿を修正しました。'
    else
      flash[:error] = '投稿の修正に失敗しました。'
    end
    redirect_to timeline_profile_path(@post.profile)
  end

  # 投稿を削除
  def destroy
    @post = Post.find(params[:id])
    @profile = @post.profile
    @post.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to timeline_profile_path(@profile)
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
