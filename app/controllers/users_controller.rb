class UsersController < ApplicationController
  before_action :set_user, only: %i[show send_confirm_email]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Successfully registered.'
      redirect_to @user
    else
      render :new
    end
  end

  def order_list
    @orders = current_user.orders
  end

  def send_confirm_email
    if @user.email_confirm
      flash[:error] = 'Email already confirmed.'
    else
      UserMailer.confirm_email(@user).deliver_later
      flash[:success] = 'Email was sent.'
    end
  end

  def confirm_email
    @user = User.find_by(confirm_token: params[:id])

    if user
      @user.email_activate
      flash[:success] = 'Your email has been confirmed.'
      redirect_to confirm_email_user_path
    else
      flash[:error] = 'Sorry. User does not exist'
      redirect_to root_url
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation)
  end
end
