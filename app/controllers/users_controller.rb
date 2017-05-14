class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:notice] = 'User was successfully created.'
      redirect_to games_path, status: 302
    else
      render :new, status: 422
    end
  end

  def show
    @user = User.find(session[:id])
    @chart = @user.bar_chart
  end


  def edit
    @user = User.find(session[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user, notice: "User details are updated successfully"
    else
      render 'edit'
    end
  end


  def destroy
    User.find(session[:id]).destroy
    logout
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :phone_number)
  end
end
