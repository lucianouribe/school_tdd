class CreateSutdents < ActiveRecord::Migration[5.0]
  def change
    create_table :sutdents do |t|
      t.string :name
      t.boolean :behaves
      t.belongs_to :lesson

      t.timestamps
    end
  end
end
