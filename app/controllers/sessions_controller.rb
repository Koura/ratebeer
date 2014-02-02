class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user.nil?
      redirect_to :back, notice: "User #{params[:username]} does not exitst!"
    else
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
