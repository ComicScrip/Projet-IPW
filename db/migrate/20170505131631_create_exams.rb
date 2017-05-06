class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.string :title
      t.date :date
      t.references :discipline, foreign_key: true, index: true
      t.timestamps
    end
  end
end