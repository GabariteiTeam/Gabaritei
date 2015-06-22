class AddModelFields < ActiveRecord::Migration
  
  def change
  
    # Roles
    add_column :roles, :name, :string
    
    # Users
    add_column :users, :name, :string
    
    # Subjects
    add_column :subjects, :name, :string
    
    # Content
    add_column :contents, :data, :binary
    
    # Courses
    add_column :courses, :name, :string
    
    # Questions
    add_column :questions, :text, :text
    add_column :questions, :answer, :text
    add_column :questions, :hot, :boolean
    add_column :questions, :date, :datetime
    add_column :questions, :type, :integer
    
    # Ratings
    add_column :ratings, :level, :integer
    add_column :ratings, :comment, :text
    
    # Responses
    add_column :responses, :text, :text
    add_column :responses, :correction, :decimal, precision: 4, scale: 2
    
    # Tests
    add_column :tests, :name, :string
    
  end
  
end
