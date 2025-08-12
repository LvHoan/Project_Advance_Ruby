class CreateLessonProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.string :status
      t.integer :progress_percent

      t.timestamps
    end
  end
end
