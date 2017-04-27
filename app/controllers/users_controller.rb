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

    if @user.destroy
      flash[:notice] = "L'utilisateur a bien été supprimé"
    end

    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "L'utilisateur a bien été mis à jour."
    end
    render 'edit'
  end

  private
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :approved)
    end

end
