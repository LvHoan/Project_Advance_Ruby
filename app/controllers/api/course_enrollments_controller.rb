class Api::CourseEnrollmentsController < ApplicationController
  before_action :set_user

  def update
    enrollment = @user.course_enrollments.find(params[:id])

    enrollment.update(course_enrollment_params)

    @total = 1
  end

  def destroy
    enrollment = @user.course_enrollments.find(params[:id])

    enrollment.destroy

    @total = 1
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def course_enrollment_params
    params.require(:course_enrollment).permit(:status)
  end
end
