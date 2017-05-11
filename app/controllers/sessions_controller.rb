class SessionsController < ApplicationController
  def new
     @user = User.new
  end

  def create
    @user = User.find_by(username: session_params[:username])
    if @user.authenticate(session_params[:password])
      login(@user)
      redirect_to user_path(@user)
    else
      render :new, status: 422
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
