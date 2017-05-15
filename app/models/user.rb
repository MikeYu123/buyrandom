class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #,
         # :omniauthable, :confirmable
  audited
  enum role: [:member, :manager, :admin]

  def can_see_admin?
     manager? || admin?
  end
end
