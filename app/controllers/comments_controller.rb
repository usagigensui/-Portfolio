class CommentsController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!

  def create
    @profile = Profile.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.profile_id = @profile.id
    if @comment.save
      flash[:notice] = "プロフィールコメントを追加しました。"
      redirect_to profile_path(params[:id])
    else
      flash[:error] = "プロフィールコメントの追加に失敗しました。"
      redirect_to profile_path(params[:id])
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "投稿を修正しました。"
      redirect_to profile_path(@comment.profile.id)
    else
      flash[:error] = "投稿の修正に失敗しました。"
      redirect_to profile_path(@comment.profile.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @profile = @comment.profile
    @comment.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to profile_path(@profile)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end
end
