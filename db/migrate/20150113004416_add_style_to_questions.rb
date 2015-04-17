class AddStyleToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :style, :string
    remove_column :questions, :type
  end
end
