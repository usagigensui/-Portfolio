class InquiriesController < ApplicationController
  # index、show、destroyはログインユーザーのみ許可
  before_action :authenticate_user!, onty: [:index, :show, :destroy]

  # フォームメール作成ページ
  def new
    @profile = Profile.find(params[:id])
    @inquiry = Inquiry.new
  end

  # 入力内容確認ページ
  def confirm
    @profile = Profile.find(params[:id])
    @inquiry = Inquiry.new(inquiry_params)
  end

  # 作成ページに戻る
  def back
    @profile = Profile.find(params[:id])
    @inquiry = Inquiry.new(inquiry_params)
    render 'new'
  end

  # メール保存・送信
  def create
    @profile = Profile.find(params[:id])
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.profile_id = @profile.id
    if @inquiry.save
      InquiryMailer.send_formmail(@profile, @inquiry).deliver_now
      flash[:notice] = "メールを送信しました。"
      redirect_to new_inquiry_path(@profile.id)
    else
      flash[:error] = "メールの送信に失敗しました。"
      render 'new'
    end
  end

  # メール一覧ページ
  def index
    @profile = Profile.find(params[:id])
    @inquiries = @profile.inquiries.reverse_order
  end

  # メール削除
  def destroy
    @inquiry = Inquiry.find(params[:id])
    @profile = @inquiry.profile
    @inquiry.destroy
    flash[:notice] = "メールを削除しました。"
    redirect_to inquiries_path(@profile)
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:sender, :email, :title, :message)
  end
end
