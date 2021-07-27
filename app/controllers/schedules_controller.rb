class SchedulesController < ApplicationController
  # index、completed以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: %i[index completed]
  # プロフィールの特定
  before_action :set_profile, except: [:destroy]

  # 予定一覧ページ
  def index
    @schedules = @profile.schedules
    @waiting_schedules = @schedules.where('(start_date > ?) or (end_date > ?)', DateTime.now, DateTime.now)
    @schedule = Schedule.new
    @link = Link.new
  end

  # 終了した予定一覧ページ
  def completed
    @schedules = @profile.schedules
    @completed_schedules = @schedules.where('(start_date < ?) or (end_date < ?)', DateTime.now, DateTime.now)
    @schedule = Schedule.new
    @link = Link.new
  end

  # 新規予定作成
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.profile_id = @profile.id
    if @schedule.save
      flash[:notice] = '予定を追加しました。'
      redirect_to schedules_path(params[:code])
    else
      flash[:error] = '予定の追加に失敗しました。'
      @schedules = @profile.schedules
      render 'index'
    end
  end

  # 予定削除
  def destroy
    @schedule = Schedule.find(params[:id])
    @profile = @schedule.profile
    @schedule.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to schedules_path(@profile)
  end

  # プロフィールの特定
  def set_profile
    @profile = Profile.find_by(code: params[:code])
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :body, :start_date, :end_date)
  end
end
