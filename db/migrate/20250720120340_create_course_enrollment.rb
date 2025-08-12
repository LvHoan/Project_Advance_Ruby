class CreateCourseEnrollment < ActiveRecord::Migration[8.0]
  def up
    create_table :course_enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.datetime :enrolled_at
      t.datetime :completed_at

      t.timestamps
    end

    add_index :course_enrollments, [:user_id, :course_id], unique: true
  end

  def down
    remove_index :course_enrollments, column: [:user_id, :course_id]

    drop_table :course_enrollments
  end
end
