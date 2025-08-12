class DropEnrollmentTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :enrollments
  end
end
