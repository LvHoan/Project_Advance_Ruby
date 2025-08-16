class User < ApplicationRecord
  has_many :course_enrollments, dependent: :destroy
  has_many :courses, through: :course_enrollments

  has_one_attached :avatar

  scope :by_id, ->(id) { where(id: id) }
end
