class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to mypage_path
    else
      render 'new'
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to mypage_path
    else
      render 'edit'
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  # def destroy
  #   @profile = Profile.find(params[:id])
  #   @profile.destroy
  #   redirect_to mypage_path
  # end

  private

  def profile_params
    params.require(:profile).permit(:code, :name, :image, :introduction)
  end
end
