class UserController < ApplicationController
  before_action :authenticate_user!, except: [:pay_callback, :pay_redirect]
  after_action :mark_notifications_as_notified, only: :show
  skip_before_action :verify_authenticity_token, only: [:pay_callback, :pay_redirect]
  SECRET_KEY = 'FyKagMwVtjgvqwFX'
  ACCOUNT = 'test'
  INPLAT_HOST = 'https://demo-v-jet.inplat.ru/'
  API_KEY = 'AmGisIKyumi8S7c8xg2tZp1C'
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

  def register_deposit
    Payment.create(sign: params[:sign], user: current_user)
  end

  def pay_callback
    render plain: 'OK'
  end

  def pay_redirect
    render plain: 'OK'
  end

  def inplat_link
    sum = params[:sum].to_f
    message = "#{ACCOUNT}:#{sum}:"
    digest = OpenSSL::Digest.new('sha256')
    sign = OpenSSL::HMAC.hexdigest(digest, SECRET_KEY, message)
    link = "#{INPLAT_HOST}?apikey=#{API_KEY}&theme=blue&title=#{URI.encode('Пополнить')}&sum=#{sum}&account=#{ACCOUNT}" \
      "&sign=#{sign}"
    render plain: link
  end

  private

  def mark_notifications_as_notified
    @winning_notifications.update_all(notified: true)
  end



  def user_params
    params.permit(:email, :password, :password_confirmation, :avatar_url, :username)
  end
end