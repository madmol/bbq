class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  PROVIDER_NAMES = {
    github: 'GitHub',
    yandex: 'Yandex'
  }

  PROVIDER_NAMES.each do |provider, provider_name|
    define_method(provider) do
      oauth_provider_auth(provider_name)
    end
  end

  private

  def auth_data
    request.env['omniauth.auth']
  end

  def oauth_provider_auth(kind)
    @user = User.from_omniauth(auth_data)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
      sign_in_and_redirect @user, event: :authentication
    else
      # Removing extra as it can overflow some session stores
      session['devise.oauth.data'] = auth_data.except('extra')
      msg = @user.errors.full_messages.join("\n")
      redirect_to new_user_registration_url, alert: msg
    end
  end
end
