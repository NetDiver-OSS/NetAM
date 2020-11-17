module Admin
  class UsersController < ApplicationController
    load_and_authorize_resource

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = 'Successfully created User.'
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? && params[:user][:password_confirmation].blank?

      if @user.update(user_params)
        flash[:notice] = 'Successfully updated User.'
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])

      return unless @user.destroy

      flash[:notice] = 'Successfully deleted User.'
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
  end
end
