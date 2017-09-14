class UsersController < Clearance::UsersController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.first_name && @user.save
      redirect_to edit_user_path(@user)
    else
      @user.previous_step
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.change_ad_next_state && @user.update_attributes(advertisement_params)
      redirect_to some_path_here && return
    else
      @user.previous_step
      render :edit && return
    end
  end

  def previous_step
    @user = User.find(params[:id])
    if !@user.loaded? && @user.previous_step && @user.save
      redirect_to edit_user_path(@user)
    else
      redirect_to :back
    end
  end

  private

    def user_params
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
