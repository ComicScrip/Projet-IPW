class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    @user.studied_disciplines.clear
    Assessment.destroy_all(student: @user)

    if @user.destroy
      flash[:notice] = "L'utilisateur a bien été supprimé"
    else
      flash[:error] = "L'utilisateur n'a pas pu être supprimé"
    end

    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    was_approved = @user.approved

    Role.all.each {|role| add_or_remove_role(@user, role.name) }

    if @user.update(user_params)
      if (not was_approved) && @user.approved
        UserMailer.user_was_approved(@user).deliver
      end
      flash[:notice] = "L'utilisateur a bien été mis à jour."
      redirect_to users_path
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :approved, :userRoles)
    end

    def add_or_remove_role(user, role)
      if params[:userRoles][role] == "1"
        user.add_role role
      elsif params[:userRoles][role] == "0"
        user.remove_role role
        # Rolify destroys the role in db if it's not referenced by any user, which is not what we want...
        Role.find_or_create_by(name: role)
      end
    end
end
