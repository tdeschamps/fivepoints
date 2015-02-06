class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require 'uuidtools'

  def facebook
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    oauthorize "Twitter"
  end

  def linkedin
    oauthorize "LinkedIn"
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def oauthorize(kind)
    @user = User.find_for_oauth(kind, request.env["omniauth.auth"], current_user)
    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
      session["devise.#{kind.downcase}_data"] = env["omniauth.auth"]
      sign_in_and_redirect @user, :event => :authentication
    end
  end

  

end