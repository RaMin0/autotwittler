class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      set_flash_message(:alert, :failure, kind: 'Twitter', reason: @user.errors.full_messages.to_sentence) if is_navigational_format?
      redirect_to root_path
    end
  end
  
  def after_omniauth_failure_path_for(scope)
    root_path
  end
end
