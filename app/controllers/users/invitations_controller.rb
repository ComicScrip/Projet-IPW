class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def update
    super do |u|
      # an invited user is automatically approved
      u.approved = true
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite) do |u|
        u.permit(:email, :lastName, :firstName)
      end
    end
end