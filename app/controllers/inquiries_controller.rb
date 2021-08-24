class InquiriesController < ApplicationController
  # index、show、destroyはログインユーザーのみ許可
  before_action :authenticate_user!, only: %i[index destroy]
  # プロフィールの特定
  before_action :set_profile, only: %i[index destroy]

  # フォームメール作成ページ
  def new
    @profile = Profile.find_by(code: params[:code])
    @inquiry = Inquiry.new
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # 入力内容確認ページ
  def confirm
    @profile = Profile.find_by(code: params[:code])
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.profile_id = @profile.id
    # バリデーション確認
    render 'new' if @inquiry.invalid?
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # 作成ページに戻る
  def back
    @profile = Profile.find_by(code: params[:code])
    @inquiry = Inquiry.new(inquiry_params)
    render 'new'
  end

  # メール保存・送信
  def create
    @profile = Profile.find_by(code: params[:code])
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.profile_id = @profile.id
    if @inquiry.save
      InquiryMailer.send_formmail(@profile, @inquiry).deliver_now
      flash[:notice] = 'メールを送信しました。'
      redirect_to new_inquiry_path(@profile)
    else
      flash[:error] = 'メールの送信に失敗しました。'
      render 'new'
    end
  end

  # メール一覧ページ
  def index
    @inquiries = @profile.inquiries.reverse_order
  end

  # メール削除
  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    flash[:notice] = 'メールを削除しました。'
    redirect_to inquiries_path(@profile)
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:sender, :email, :title, :message)
  end
end
