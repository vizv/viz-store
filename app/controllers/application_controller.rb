class ApplicationController < ActionController::Base
  include Manage::ResourcesHelper
  protect_from_forgery with: :exception

  def resource
    @bucket = params[:bucket]
    @path = params[:path]
    (format = params[:format]) && (@path = "#{@path}.#{format}")

    begin
      resource = Bucket.find_by(name: @bucket).resources.find_by(path: @path)
      cached_file = retrieve_file resource
    rescue Mongoid::Errors::DocumentNotFound => e
      @error = 'File not found!'
      report
      return
    end

    send_file cached_file, disposition: 'inline'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username, :password, :remember_me)
    end
  end

  def report status = :not_found, json = { bucket: @bucket, path: "/#{@path}" }
    json[:error] = @error unless @error.nil?
    render status: :not_found, content_type: 'application/json', json: json
  end
end
