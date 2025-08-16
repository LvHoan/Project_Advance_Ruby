class CourseEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum(:status, {
    pending: 0,
    active: 1,
    completed: 2,
    canceled: 3
  })

  validates :user_id, uniqueness: { scope: :course_id, message: 'has already enrolled in this course' }

end
