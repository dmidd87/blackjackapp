class RegistrationsController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(
    :email_address, :first_name, :last_name, :password, :password_confirmation
    ))
    if
      @user.save
      session[:user_id] = @user.id
      redirect_to games_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation, :pivot_token)
  end
end
