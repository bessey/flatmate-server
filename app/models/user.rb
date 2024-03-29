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
  attr_accessible :flat_approved, :colour_id

  validates :email, :first_name, :presence => true
  validates :email, :uniqueness => true

  belongs_to :flat
  has_one :gcm_device, :class_name => "Gcm::Device", :dependent => :destroy

  before_save :defaults

  default_scope order(:first_name)

  def defaults
    if self.flat_approved.nil? or (self.flat_id_was != nil and self.flat_id_changed?)
      self.flat_approved = false
    end

    return true
  end
end
