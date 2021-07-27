class CommentsController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!

  # 自己紹介コメントを新規作成
  def create
    @profile = Profile.find_by(code: params[:code])
    @comment = Comment.new(comment_params)
    @comment.profile_id = @profile.id
    if @comment.save
      flash[:notice] = 'プロフィールコメントを追加しました。'
    else
      flash[:error] = 'プロフィールコメントの追加に失敗しました。'
    end
    redirect_to profile_path(params[:code])
  end

  # 自己紹介コメントを編集
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = '投稿を修正しました。'
    else
      flash[:error] = '投稿の修正に失敗しました。'
    end
    redirect_to profile_path(@comment.profile)
  end

  # 自己紹介コメントを削除
  def destroy
    @comment = Comment.find(params[:id])
    @profile = @comment.profile
    @comment.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to profile_path(@profile)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end
end
