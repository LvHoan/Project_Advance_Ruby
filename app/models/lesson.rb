class Lesson < ApplicationRecord
  belongs_to :course

  scope :by_lesson_id, ->(id) { where(id: id) }
end
