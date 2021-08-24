class LinksController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!
  # 操作ユーザーの確認
  before_action :set_profile

  # リンクの新規登録画面
  def new
    @link = Link.new
  end

  # リンクを新規作成
  def create
    @link = Link.new(link_params)
    @link.profile_id = @profile.id
    if @link.save
      flash[:notice] = 'リンクを追加しました。'
    else
      flash[:error] = 'リンクの追加に失敗しました。'
    end
    redirect_to profile_path(params[:code])
  end

  # リンク一覧ページ
  def index
    @links = @profile.links
  end

  # リンクを編集
  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:notice] = 'リンクを修正しました。'
    else
      flash[:error] = 'リンクの修正に失敗しました。'
    end
    redirect_to links_path(@profile)
  end

  # リンクを削除
  def destroy
    @link = Link.find(params[:id])
    @profile = @link.profile
    @link.destroy
    flash[:notice] = 'リンクを削除しました。'
    redirect_to links_path(@profile)
  end

  private

  def link_params
    params.require(:link).permit(:url, :category)
  end
end
