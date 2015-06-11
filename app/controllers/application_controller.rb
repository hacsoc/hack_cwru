class ApplicationController < ActionController::Base
  include Clearance::Controller

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    respond_to do |format|
      format.html { render file: File.join(Rails.root, 'public', '404.html') }
      format.json { render json: nil, status: 404 }
    end
  end
end
