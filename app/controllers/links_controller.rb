class LinksController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!

  # リンクを新規作成
  def create
    @profile = Profile.find_by(code: params[:code])
    @link = Link.new(link_params)
    @link.profile_id = @profile.id
    if @link.save
      flash[:notice] = "リンクを追加しました。"
      redirect_to profile_path(params[:code])
    else
      flash[:error] = "リンクの追加に失敗しました。"
      redirect_to profile_path(params[:code])
    end
  end

  # リンクを編集
  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:notice] = "リンクを修正しました。"
      redirect_to links_path(@link.profile)
    else
      flash[:error] = "リンクの修正に失敗しました。"
      redirect_to links_path(@link.profile)
    end
  end

  # リンク一覧ページ
  def index
    @profile = Profile.find_by(code: params[:code])
    @links = @profile.links
  end

  # リンクを削除
  def destroy
    @link = Link.find(params[:id])
    @profile = @link.profile
    @link.destroy
    flash[:notice] = "リンクを削除しました。"
    redirect_to links_path(@link.profile)
  end

  private

  def link_params
    params.require(:link).permit(:url, :category)
  end
end
