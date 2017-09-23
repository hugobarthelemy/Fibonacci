class UsersController < Clearance::UsersController
  def new
    # @user = User.new
    if session[:user_id].present?
       @user = User.find(session[:user_id])
       # @user.build_situation && @user.build_technical_info
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
      @user.fill_the_first_step_of_form!
      redirect_to sign_up_path(@user)
    elsif @user.second_step_of_form?
      @user.fill_the_second_step_of_form!
      sign_in @user
      session[:user_id] = nil
      redirect_back_or url_after_create
    end
    @user.update_attributes(user_params)
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
