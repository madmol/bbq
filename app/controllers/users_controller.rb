class UsersController < ApplicationController
  before_action :authenticate_user!, :set_current_user, except: %i[show]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('controllers.users.updated')
    else
      render :edit
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar)
  end
end
