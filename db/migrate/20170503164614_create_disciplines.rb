class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.date :beginsOn
      t.date :endsOn
      t.references :owner, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
