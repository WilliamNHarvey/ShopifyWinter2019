class LoginController < ApplicationController
  def post
    user = User.find_by(params[:username]).try(:authenticate, params[:password])
    if user
      session[:current_user_id] = user.id
      respond_to do |format|
        format.json { render json: @user }
      end
    else
      # for debugging purposes
      session[:current_user_id] = nil
      respond_to do |format|
        format.json { render json: [error: "Wrong username/password"] }
      end
    end
  end
end
