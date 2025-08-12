class ChangeStatusToIntegerInLessonProgresses < ActiveRecord::Migration[8.0]
  # def up
  #   add_column :lesson_progresses, :status, :integer, default: 0, null: false
  # end

  def down
    remove_column :lesson_progresses, :status, :string
  end
end
