class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_default_response_format, if: "Rails.env.production?"
  skip_before_action :verify_authenticity_token, :only => [:create, :update, :login, :invite]

  # CUSTOM EXCEPTION HANDLING #http://www.mattjohnston.co/blog/2013/10/18/responding-with-errors-in-rails/
  rescue_from Exception, with: :error

  protected

  def set_default_response_format
    request.format = :json
  end
  
  def error(e)
    # 200 :ok
    # 201 :created
    # 202 :accepted
    # 400 :bad_request
    # 401 :unauthorized
    # 403 :forbidden
    # 500 :internal_server_error
    if Rails.env.production?
      render json: { :error => e.message }, :status => :internal_server_error
    else
      raise e
    end
  end

end
