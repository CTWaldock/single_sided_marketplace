class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts

  def destroy
    update_attributes(deactivated: true) unless deactivated
  end
  
  def active_for_authentication?
    super && !deactivated
  end
end
