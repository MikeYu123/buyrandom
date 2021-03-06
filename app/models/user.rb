class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #,
         # :omniauthable, :confirmable
  audited
  enum role: [:member, :manager, :admin]

  has_many :bids, as: :source
  has_many :deposits, as: :destination

  def can_see_admin?
     manager? || admin?
  end

  def has_enough_to_bid?(amount)
    balance > amount
  end

  def withdraw amount
    raise ArgumentError if balance < amount
    update(balance: balance - amount)
  end

  def deposit amount
    update(balance: balance + amount)
  end

end
