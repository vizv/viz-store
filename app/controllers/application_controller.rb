class ApplicationController < ActionController::Base
  include Manage::ResourcesHelper
  protect_from_forgery with: :exception
  rescue_from Exception, :with => :report_internal_error

  def resource
    @bucket = params[:bucket]
    @path = params[:path]
    (format = params[:format]) && (@path = "#{@path}.#{format}")

    begin
      resource = Bucket.find_by(name: @bucket).resources.find_by(path: @path)
      cached_file = retrieve_file resource
    rescue Mongoid::Errors::DocumentNotFound => e
      @error = '文件未找到'
      report :not_found, bucket: @bucket, path: "/#{@path}"
      return
    end

    send_file cached_file, disposition: 'inline'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username, :password, :remember_me)
    end
  end

  def report status, json
    json[:error] = @error unless @error.nil?
    render status: status, content_type: 'application/json', json: json
  end

  # TODO: stub
  def authenticate_user!
  end

  private

  def report_internal_error
    report :internal_server_error, error: '未知的内部错误'
  end
end
