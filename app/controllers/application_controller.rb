class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # authentication required on every
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      if current_user.has_role? :student
        return my_grades_path
      elsif current_user.has_role? :teacher
        return exams_path
      elsif current_user.has_role? :admin
        return users_path
      else
        return root_path
      end
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  protected
    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to new_user_session_path
      end
    end
end
