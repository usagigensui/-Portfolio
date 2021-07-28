class InquiriesController < ApplicationController
  # index、show、destroyはログインユーザーのみ許可
  before_action :authenticate_user!, only: %i[index destroy]
  # プロフィールの特定
  before_action :set_profile, except: [:destroy]

  # フォームメール作成ページ
  def new
    @inquiry = Inquiry.new
    @link = Link.new
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # 入力内容確認ページ
  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    @link = Link.new
    # 非公開プロフィールへのアクセスをブロック
    release_check(@profile)
  end

  # 作成ページに戻る
  def back
    @inquiry = Inquiry.new(inquiry_params)
    render 'new'
  end

  # メール保存・送信
  def create
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
    @profile = @inquiry.profile
    @inquiry.destroy
    flash[:notice] = 'メールを削除しました。'
    redirect_to inquiries_path(@profile)
  end

  # プロフィールの特定
  def set_profile
    @profile = Profile.find_by(code: params[:code])
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:sender, :email, :title, :message)
  end
end
