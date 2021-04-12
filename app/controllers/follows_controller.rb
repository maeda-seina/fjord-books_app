# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to @user, notice: 'ユーザーをフォローしました'
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to @user, notice: 'ユーザーのフォローを解除しました'
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
