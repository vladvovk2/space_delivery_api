class UsersController < ApplicationController
  before_action :set_user, only: %i[show send_confirm_email change_receipt_status order_list]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Successfully registered.'
      redirect_to login_path
    else
      render :new
    end
  end

  def order_list
    @orders = @user.orders
  end

  def send_confirm_email
    if @user.email_confirm
      send_notification 'Email already confirmed.'
    else
      send_notification "Email was sent to: #{@user.email}"
      UserMailer.confirm_email(@user.id).deliver
    end

    respond_to { |format| format.js }
  end

  def confirm_email
    @user = User.find_by(confirm_token: params[:id])

    if @user.email_activate
      send_notification 'Your email has been confirmed.'
      redirect_to @user
    else
      redirect_to root_url
      send_notification 'Sorry. User does not exist.'
    end
  end

  def change_receipt_status
    if @user.email_confirm
      @user.change_get_receipt_status
      send_notification 'Status changed.'
    else
      send_notification 'You must confirm your email.'
    end

    respond_to { |format| format.js }
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation)
  end
end
