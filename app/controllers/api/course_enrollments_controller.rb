class Api::CourseEnrollmentsController < ApplicationController
  include CommonValidator

  before_action :ensure_user!
  before_action :ensure_course!, only: :create
  before_action :ensure_enrollment!

  def create
    raise ActiveRecord::RecordNotFound, I18n.t("message.course_already_enrolled") if @enrollment.present?

    CourseEnrollment.create!(
      user: @user,
      course: @course,
      status: :active
    )
    NotificationMailer.course_registration_success(@user, @course).deliver_later
    @total = 1
  end

  def update
    @enrollment.update(course_enrollment_params)
    @total = 1
  end

  def destroy
    @enrollment.destroy!
  end

  private

  def ensure_enrollment!
    @enrollment = @user.course_enrollments.find_by(course_id: params[:course_id])
  end

  def course_enrollment_params
    params.require(:course_enrollment).permit(:status)
  end
end
