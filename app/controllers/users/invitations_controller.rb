class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_filter :authenticate_user!, only: [:edit, :update]

  def create
    @inviter = current_user
    super do |u|
      if not u.valid?
        return render :new
      end
    end
  end

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

    def current_inviter
      current_user
    end

    def invite_resource
      resource_class.invite!(invite_params, current_inviter) do |invitable|
        invitable.add_role(:student)
      end
    end
end