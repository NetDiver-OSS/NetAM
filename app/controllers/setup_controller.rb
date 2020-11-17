# frozen_string_literal: true

class SetupController < ApplicationController
  before_action :setup_finished

  def install
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :finished
    else
      render :install
    end
  end

  private

  def setup_finished
    render :finished unless User.all.size.zero?
  end

  def user_params
    params[:user][:admin] = true
    params.require(:user).permit(:email, :password, :password_confirmation, :admin)
  end
end
