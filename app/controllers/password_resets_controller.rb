class PasswordResetsController < ApplicationController
 # def index
 # end
 def new
  @user = User.new
 end

 def update
  @user = User.find_by(email: user_params[:email])
  if @user && @user.phone_number == user_params[:phone_number]
    otp = random_otp
    @user.update_attributes(password: otp)
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @client.messages.create(
      from: '+17314514935',
      to: "#{@user.phone_number}",
      body: "Your current password id #{otp}. Login and update your password soon."
    )
  else
    render :new, status: 422
  end
 end

 private

 def random_otp
    ([*('A'..'Z'),*('0'..'9'),*('a'..'z')]-%w(0 1 I O)).sample(8).join
 end

 def user_params
    params.require(:user).permit(:username, :email, :phone_number)
  end
end
