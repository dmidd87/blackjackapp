class AuthenticationsController < ApplicationController

  def destroy
    session.clear
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email_address(params[:email_address].downcase)
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to users_path
      else
      @sign_in_error = "Username / password combination is invalid"
      render :new
      end
  end
end
