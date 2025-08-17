class Api::CoursesController < ApplicationController
  include CommonValidator

  before_action :ensure_user!

  def list
    @courses = @user.courses
  end

  def bulk_update
    records = build_records(course_data_params)

    ActiveRecord::Base.transaction do
      Course.import(records,
                    on_duplicate_key_update: %i[title description image_url updated_at])
      enroll_new_courses(records)
    end

    @total = records.size
  end

  def destroy
    course = @user.courses.by_course_id(params[:id]).first
    raise ActiveRecord::RecordNotFound, I18n.t("message.not_found.default") if course.blank?

    course.destroy
  end

  private

  def course_data_params
    params.require(:courses).map { |course| course.permit(:id, :title, :description, :image_url) }
  end

  def build_records(course_params)
    existing_courses = @user.courses.index_by(&:id)

    course_params.map do |attrs|
      if existing_courses[attrs[:id]].present?
        existing_courses[attrs[:id].to_i].tap do |course|
          course.assign_attributes(attrs.merge(AttributeUtils.update_hash))
        end
      else
        Course.new(attrs.merge(AttributeUtils.create_hash))
      end
    end
  end

  def enroll_new_courses(new_courses)
    CourseEnrollment.import(new_courses.map do |course|
      CourseEnrollment.new(user_id: @user.id, course_id: course.id, status: :active)
    end)
  end
end
