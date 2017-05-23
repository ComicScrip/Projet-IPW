class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # authentication required everywhere by default
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def after_sign_in_path_for(resource)
    referer_url_without_params = request.referer.split('?').first || nil
    sign_in_url = new_user_session_url
    edit_invitation_url = accept_user_invitation_url

    if referer_url_without_params == sign_in_url
      if current_user.has_role? :student
        return my_grades_path
      elsif current_user.has_role? :teacher
        return exams_path
      elsif current_user.has_role? :admin
        return users_path
      else
        return root_path
      end
    elsif referer_url_without_params == edit_invitation_url
      return root_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  protected
    def authenticate_user!(opts={})
      if user_signed_in?
        super
        opts[:scope] = :user
        warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
      else
        redirect_to new_user_session_path
      end
    end
end
