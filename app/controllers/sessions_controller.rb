class SessionsController < ApplicationController
  def create
    @user = User.find_by(phone_number: params[:phone_number])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to blogs_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
