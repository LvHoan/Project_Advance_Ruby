class Course < ApplicationRecord
  has_many :lessons, dependent: :destroy

  has_many :course_enrollments, dependent: :destroy
  has_many :users, through: :course_enrollments

  has_one_attached :image

  scope :by_course_id, ->(id) { where(id: id) }
end
