class Lesson < ApplicationRecord
  belongs_to :course

  has_many :lesson_progresses, dependent: :destroy
end
