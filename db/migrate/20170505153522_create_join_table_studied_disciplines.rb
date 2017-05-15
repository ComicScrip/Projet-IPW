class CreateJoinTableStudiedDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :disciplines do |t|
      t.index :user_id
      t.index :discipline_id
    end
  end
end
