class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.text :name
      t.integer :professor_id
      t.integer :department_id
      t.text :descricao
      
      t.timestamps
    end
  end
end
