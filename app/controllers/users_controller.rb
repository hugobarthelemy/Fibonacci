class UsersController < Clearance::UsersController
  def new
    if session[:user_id].present?
      @user = User.find(session[:user_id])
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.fill_the_first_step_of_form!
      session[:user_id] = @user.id
      redirect_to sign_up_path(@user)
      # TODO -> send welcome mail
    else
      @user.fill_the_first_step_of_form!
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.first_step_of_form?
      @user.update_attributes!(user_params)
      @user.fill_the_first_step_of_form!
      redirect_to sign_up_path(@user)
    elsif @user.second_step_of_form?
      @user.fill_the_second_step_of_form!
      sign_in @user
      session[:user_id] = nil
      @user.update_attributes!(user_params)
      redirect_back_or url_after_create
    end
  end

  def back_to_the_first_step_of_form
    @user = User.find(session[:user_id])
    @user.back_to_the_first_step_fo_form!
    redirect_to sign_up_path
  end

  private

    def user_params
      user_params = params.require(:user).permit(:user_id,
        :email,
        :password,
        :first_name,
        :last_name,
        :street_number,
        :street,
        :zip,
        :city,
        :situation,
        :technical_informations)
      user_params.delete(:password) unless user_params[:password].present?
      user_params
    end
end
