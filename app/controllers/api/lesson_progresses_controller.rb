class Api::LessonProgressesController < ApplicationController
  before_action :set_course

  def list
    progresses = @user.lesson_progresses.includes(:lesson)
    render json: progresses.map { |progress|
      lesson = progress.lesson
      {
        lesson_id: lesson.id,
        title: lesson.title,
        progress: progress.progress,
        status: progress.status,
        updated_at: progress.updated_at
      }
    }
  end

  def update
    progress = @course.lesson.lesson_progresses
    progress.assign_attributes(progress_params)

    progress.save
  end

  private

  def set_course
    @user = Course.find(params[:course_id])
  end

  def progress_params
    params.permit(:progress, :status)
  end
end
