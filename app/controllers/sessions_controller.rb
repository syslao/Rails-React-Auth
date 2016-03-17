class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        format.json { render :text => user.access_token }
        # log_in user
        # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # redirect_back_or user
      else
        format.json { render text: "Email and password combination are invalid", status: :unprocessable_entity }
        # flash.now[:danger] = 'Invalid email/password combination'
        # render 'new'
      end
    end
  end

  def verify_access_token
    user = User.find_by(access_token: params[:session][:access_token])
    if user
      render :text => "verified"
    else
      render text: "Token failed verification", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
