class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def resource
    render status: :not_implemented,
           content_type: 'application/json', json: params
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username, :password, :remember_me)
    end
  end
end
