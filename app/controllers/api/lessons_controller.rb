class Api::LessonsController < ApplicationController
  before_action :set_course

  def list
    lesson_progresses = @course.lessons.lesson_progresses

    @lessons = lesson_progresses.map do |lesson_progress|
      lesson = lesson_progress.lesson
      {
        lesson_id: lesson.id,
        lesson_title: lesson.title,
        lesson_description: lesson.description,
        percentage_completed: lesson_progress.percentage_completed,
        updated_at: lesson_progress.updated_at
      }
    end

    render json: @lessons
  end

  def bulk_update
    updated_count = 0
    created_count = 0

    lesson_data_params.each do |attrs|
      lesson = attrs[:id].present? ? @course.lessons.find_by(id: attrs[:id]) : @user.lessons.new

      safe_attrs = attrs.except(:id, :created_at, :updated_at)
      lesson.assign_attributes(safe_attrs)

      if lesson.save
        lesson.persisted? ? updated_count += 1 : created_count += 1
      else
        Rails.logger.warn("Failed to save lesson: #{lesson.errors.full_messages.join(', ')}")
      end
    end

    total = created_count + updated_count
    render json: { updated: updated_count, created: created_count, total: total }, status: :ok
  end

  def destroy
    lesson = @course.lessons.find_by(id: params[:id])
    if lesson
      lesson.destroy!
      render json: { message: 'Deleted' }
    else
      render json: { error: 'Lesson not found' }, status: :not_found
    end
  end

  private

  def set_course
    @course = Course.find_by(id: params[:course_id])
  end

  def lesson_data_params
    params.require(:lessons).map do |lesson|
      lesson.permit(:id, :title, :description, :image_url)
    end
  end
end
