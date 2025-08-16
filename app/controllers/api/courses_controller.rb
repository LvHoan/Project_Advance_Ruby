class Api::CoursesController < ApplicationController
  before_action :set_user

  def list
    @courses = @user.courses
  end

  def bulk_update
    insert_records, update_records = bulk_insert_and_update_records(course_data_params)

    ActiveRecord::Base.transaction do
      if insert_records.any?
        Course.import(insert_records)
        enroll_new_courses(insert_records)
      end

      if update_records.any?
        Course.import update_records,
                      on_duplicate_key_update: [:title, :description, :image_url, :updated_at]
      end
    end

    @total = insert_records.size + update_records.size
  end

  def destroy
    course = @user.courses.by_id(params[:id]).first!
    course.destroy!

    @total = 1
  end

  private

  def set_user
    @user = User.by_id(params[:user_id]).first!
  end

  def course_data_params
    params.require(:courses).map do |course|
      course.permit(:id, :title, :description, :image_url)
    end
  end

  def bulk_insert_and_update_records(course_data_params)
    insert_records = []
    update_records = []

    ids = course_data_params.map { |attrs| attrs[:id] }.compact
    existing_courses = @user.courses.by_id(ids).index_by(&:id)

    course_data_params.each do |attrs|
      if existing_courses[attrs[:id]].present?
        course = existing_courses[attrs[:id].to_i].assign_attributes(attrs.merge(AttributeUtils.update_hash))
        update_records << course
      else
        course = Course.new(attrs.merge(AttributeUtils.create_hash))
        insert_records << course
      end
    end

    [insert_records, update_records]
  end

  def enroll_new_courses(new_courses)
    enrollments = new_courses.map do |course|
      CourseEnrollment.new(user_id: @user.id, course_id: course.id, status: :active)
    end
    CourseEnrollment.import(enrollments)
  end
end
