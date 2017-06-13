class UsersController < ApplicationController
  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
    #  @followers = Relationship.where(followed_id: @user.id)
  end
end
