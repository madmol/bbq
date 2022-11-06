class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
    :omniauthable, omniauth_providers: [:github, :yandex]
  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :photos, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    authorization = Authorization.find_by(provider: auth.provider, uid: auth.uid)

    if authorization
      return authorization.user
    end

    email = auth.info.email.try(&:downcase)
    existing_user = find_for_database_authentication(email: email)

    if existing_user
      existing_user.add_oauth_authorization(auth).save
      return existing_user
    end

    create_new_user_from_oauth(auth, email)
  end

  def add_oauth_authorization(data)
    authorizations.build({
      provider: data.provider,
      uid: data.uid,
      email: data.info.email
    })
  end

  def author?(obj)
    obj.user == self
  end

  private

  def self.create_new_user_from_oauth(auth, email)
    user = User.new({
      email: email,
      name: email.split('@').first.gsub('.', ''),
      password: Devise.friendly_token[0, 20]
    })

    user.skip_confirmation!
    user.add_oauth_authorization(auth)
    user.save
    user
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
