class SessionsController < ApplicationController
  def new
    @session_form = SessionForm.new
  end

  def create
    @session_form = SessionForm.new(session_form_params)

    if @session_form.valid?
      session[:user_id] = @session_form.user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def session_form_params
    params.require(:session_form).permit(:phone_number, :password)
  end
end
