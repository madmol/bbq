class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, :datetime, :user, presence: true

  def subscribers_mailing_list(exclude_email)
    subscriptions.map(&:user_email) + [user.email] - [exclude_email]
  end

  def visitors
    subscribers + [user]
  end

  def pincode_valid?(pin2check)
    pincode == pin2check
  end
end
