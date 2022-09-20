class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :photos, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def author?(obj)
    obj.user == self
  end

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
      .update_all(user_id: self.id)
  end
end
