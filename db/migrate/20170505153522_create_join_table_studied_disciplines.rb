class CreateJoinTableStudiedDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_join_table :students, :disciplines do |t|
      t.index :student_id
      t.index :discipline_id
    end
  end
end
