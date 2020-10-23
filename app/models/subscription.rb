class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :search_user_by_email, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def search_user_by_email
    user_to_check = User.find_by(email: user_email)

    if user_to_check.present?
      errors.add(:base, :email_used, email: user_to_check.email)
    end
  end
end

