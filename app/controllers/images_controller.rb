class ImagesController < ApplicationController
  # ログインユーザーのみ許可
  before_action :authenticate_user!, except: [:index]
  # プロフィールの特定
  before_action :set_profile, except: [:index]

  # ギャラリーページ
  def index
    @profile = Profile.find_by(code: params[:code])
    @images = @profile.images.page(params[:page]).per(20).reverse_order
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # 新規投稿画面
  def new
    @image = Image.new
  end

  # 新規投稿
  def create
    @image = Image.new(image_params)
    @image.profile_id = @profile.id
    if @image.save
      flash[:notice] = '画像を追加しました。'
    else
      flash[:error] = '画像の追加に失敗しました。'
    end
    redirect_to images_path(@image.profile)
  end

  # 投稿一覧
  def list
    @images = @profile.images.page(params[:page]).per(20).reverse_order
  end

  # 投稿編集画面
  def edit
    @image = Image.find(params[:id])
    render 'edit'
  end

  # 投稿を編集
  def update
    @image = Image.find(params[:id])
    if @image.update(image_params)
      flash[:notice] = '画像を修正しました。'
    else
      flash[:error] = '画像の修正に失敗しました。'
    end
    redirect_to list_images_path(@profile)
  end

  # 投稿を削除
  def destroy
    @image = Image.find(params[:id])
    @profile = @image.profile
    @image.destroy
    flash[:notice] = '画像を削除しました。'
    redirect_to list_images_path(@profile)
  end

  private

  def image_params
    params.require(:image).permit(:body, :title)
  end
end
