class RegistrationsController < PublicController

  def index
  end

  def new
  end

  def user
    @user = User.new
  end

  def create
    @ user = User.new(params.require(:user).permit(
    :email_address, :first_name, :last_name, :password, :password_confirmation
    ))
  end
end
