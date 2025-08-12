class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
