class FollowController < ApplicationController
  before_action :look_user

  def following
    @title = t "following"
    @users = @user.following.page(params[:page]).per Settings.per_page
    render "users/show_follow"
  end

  def followers
    @title = t "followers"
    @users = @user.followers.page(params[:page]).per Settings.per_page
    render "users/show_follow"
  end

  private

  def look_user
    @user = User.find_by id: params[:id]
  end
end
