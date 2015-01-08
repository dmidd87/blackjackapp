class UsersController < ApplicationController

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation, :pivot_token)
  end
end
