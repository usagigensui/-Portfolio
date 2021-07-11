class ProfilesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find_by(cord: params[:id])
  end

  def destroy
  end
end
