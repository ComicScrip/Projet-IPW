class CreateAssessments < ActiveRecord::Migration[5.0]
  def change
    create_table :assessments do |t|
      t.float :grade
      t.references :student, index: true, foreign_key: {to_table: :users}
      t.references :exam, foreign_key: true, index: true
      t.timestamps
    end
  end
end
