class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token
  attr_accessible :first_name, :flat_id, :geocode_lat, :geocode_long, :last_name, :phone_number

  validates :email, :first_name, :presence => true
  validates :email, :uniqueness => true

  belongs_to :flat
end
