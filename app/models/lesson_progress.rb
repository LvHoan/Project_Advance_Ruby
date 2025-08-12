class LessonProgress < ApplicationRecord
  belongs_to :lesson

  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  enum(:status, {
    not_started: 0,
    in_progress: 1,
    completed: 2
  })
end
