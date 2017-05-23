class UserController < ApplicationController
  before_action :authenticate_user!, except: [:pay_callback, :pay_redirect]
  after_action :mark_notifications_as_notified, only: :show
  skip_before_action :verify_authenticity_token, only: [:pay_callback, :pay_redirect]
  SECRET_KEY = 'FyKagMwVtjgvqwFX'
  INPLAT_HOST = 'https://demo-v-jet.inplat.ru/'
  API_KEY = 'AmGisIKyumi8S7c8xg2tZp1C'
  def show
    @payment = params[:payment]
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
  end

  def pay_callback
    code = params['code'].to_i
    account = params['params']['account'].to_i
    sum = (params['params']['sum'].to_f) / 100
    id = params['id'].to_s
    if code == 0
      PaymentService.new(inplat_id: id, id: account, amount: sum).call
    end
    render plain: 'OK'
  end

  def pay_redirect
    redirect_to user_show_path(payment: true)
  end

  def inplat_link
    sum = params[:sum].to_f
    message = "#{current_user.id}:#{sum}:"
    digest = OpenSSL::Digest.new('sha256')
    sign = OpenSSL::HMAC.hexdigest(digest, SECRET_KEY, message)
    link = "#{INPLAT_HOST}?apikey=#{API_KEY}&theme=blue&title=#{URI.encode('Пополнить')}&sum=#{sum}&account=#{current_user.id}" \
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