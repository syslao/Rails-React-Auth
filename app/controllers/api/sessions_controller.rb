module Api
  class SessionsController < ApplicationController

    def new
    end

    def create
      user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          render :text => user.access_token, status: 201
        else
          render text: "Email and password combination are invalid", status: :unprocessable_entity
        end
    end

    def verify_access_token
      user = User.find_by(access_token: params[:session][:access_token])
      if user
        render text: "verified", status: 201
      else
        render text: "Token failed verification", status: :unprocessable_entity
      end
    end

  end
end
