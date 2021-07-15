class SchedulesController < ApplicationController
  # show以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:index]
  # プロフィールの特定
  before_action :set_profile, except: [:destroy]

  def index
    @schedules = @profile.schedules
    @bygone_list = @schedules.where("schedules.start_date < ?", DateTime.now).reorder(:start)
    @future_list = @schedules.where("schedules.start_date > ?", DateTime.now).reorder(:start)
    @schedule = Schedule.new
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.profile_id = @profile.id
    if @schedule.save
      flash[:notice] = "予定を追加しました。"
      redirect_to schedules_path(params[:id])
    else
      flash[:error] = "予定の追加に失敗しました。"
      @schedules = @profile.schedules
      render 'index'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @profile = @schedule.profile
    @schedule.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to schedules_path(@profile)
  end

   # プロフィールの特定
  def set_profile
    @profile = Profile.find(params[:id])
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :body, :start_date, :end_date)
  end
end
