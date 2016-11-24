class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :subject, null: false
      t.string :teacher, null: false
      t.string :bully
      t.string :bullied
      t.belongs_to :kindergarten

      t.timestamps
    end
  end
end
