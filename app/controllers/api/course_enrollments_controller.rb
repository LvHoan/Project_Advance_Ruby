class Api::CourseEnrollmentsController < ApplicationController
  include CommonValidator
  before_action :ensure_user!
  before_action :ensure_enrollment!, only: %i[update destroy]

  def update
    @enrollment.update(course_enrollment_params)
    @total = 1
  end

  def destroy
    @enrollment.destroy
  end

  private

  def ensure_enrollment!
    @enrollment = @user.course_enrollments.find(params[:id])
  end

  def course_enrollment_params
    params.require(:course_enrollment).permit(:status)
  end
end
