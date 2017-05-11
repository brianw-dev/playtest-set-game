class SessionsController < ApplicationController

  def new
     @user = User.new
  end

  def create
    @user = User.find_by(username: params["username"])
    if @user.authenticate(params["password"])
      login(@user)
      redirect_to user_path(@user)
    else
      render :new, status: 422
    end
  end

end
