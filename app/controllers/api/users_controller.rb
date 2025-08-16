class Api::UsersController < ApplicationController
  require 'aws-sdk-s3'

  before_action :set_user, only: [:destroy, :update]

  def list
    @users = User.all
  end

  def destroy
    @user.destroy

    @total = 1
  end

  def create
    user = User.new(user_params_with_avatar)
    user.save

    @total = 1
  end

  def update
    @user.update(user_params_with_avatar)

    @total = 1
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def user_params_with_avatar
    avatar_url = S3Uploader.upload_avatar(params[:user][:avatar]) if params[:user][:avatar].present?
    user_params.merge(avatar_url: avatar_url)
  end
end
