class UsersController < Clearance::UsersController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_from_params)

    if @user.save
      sign_in @user

      redirect_back_or url_after_create
    else
      render :new
    end
  end

  private

  def user_from_params
    params.require(:user).permit(:email,
      :password,
      :first_name,
      :last_name,
      :street_number,
      :zip,
      :city,
      :situation,
      :technical_informations)
  end
end
