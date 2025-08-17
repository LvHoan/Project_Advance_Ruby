class Api::UsersController < ApplicationController
  include CommonValidator

  before_action :ensure_user!, only: %i[update destroy]

  def list
    @users = User.all
  end

  def create
    User.create!(user_params_with_avatar)
    @total = 1
  end

  def update
    @user.update!(user_params_with_avatar)
    @total = 1
  end

  def destroy
    @user.destroy!
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def user_params_with_avatar
    avatar = params[:user][:avatar]
    raise ActionController::BadRequest, I18n.t('message.fail_to_upload_avatar') unless avatar.present?

    user_params.merge(avatar_url: S3Uploader.upload_avatar(avatar))
  end
end
