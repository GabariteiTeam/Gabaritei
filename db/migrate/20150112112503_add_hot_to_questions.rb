class AddHotToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :hot, :boolean
  end
end
