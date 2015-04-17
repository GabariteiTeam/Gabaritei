class CreateQuestions < ActiveRecord::Migration
  #No futuro talvez seja bom adicionar indices nessa tabela
  def change
    create_table :questions do |t|
      t.text :question
      t.string :type
      t.datetime :year
      t.string :area
      
      t.belongs_to :subject
      
      t.timestamps
    end

  end
end
