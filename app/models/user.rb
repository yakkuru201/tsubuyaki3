class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :bio, :name, :avatar
  # attr_accessible :title, :body
  has_many :tweets
  has_many :favorites

  has_many :follows
  has_many :following_users, through: :follows, source: :user
  has_many :inverse_follows, class_name: Follow, foreign_key: :followed_id
  has_many :followed_users, through: :inverse_follows

  mount_uploader :avatar, AvatarUploadrer

  validates :name, uniqueness: true

  def followed? user
    Follow.exists?(user_id: user.id, followed_id: self.id)
  end
end
