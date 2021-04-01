# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
  end

  def update; end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :postal_code, :address, :introduction)
  end
end
