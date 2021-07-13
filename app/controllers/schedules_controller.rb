class SchedulesController < ApplicationController
  # show以外はログインユーザーのみ許可
  before_action :authenticate_user!, except: [:index]
  # プロフィールの特定
  before_action :set_profile

  def index
    @schedules = @profile.schedules
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

  def edit
  end

  def update
  end

  def destroy
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
