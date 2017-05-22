class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    new_balance = @user.balance.to_f + params[:deposit].to_f
    @user.update(user_params)
    @user.update(balance: new_balance)
    render 'user/show'
  end

  def reset_password
  end

  def deposit
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :avatar_url, :username)
  end
end