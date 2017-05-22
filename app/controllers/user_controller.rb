class UserController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_notifications_as_notified, only: :show

  def show
    @user = current_user
    @winning_notifications = AuctionWinningNotification.where(user: @user, notified: false).includes(source: :product)
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

  def mark_notifications_as_notified
    @winning_notifications.update_all(notified: true)
  end

  def user_params
    params.permit(:email, :password, :password_confirmation, :avatar_url, :username)
  end
end