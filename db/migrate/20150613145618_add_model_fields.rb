class AddModelFields < ActiveRecord::Migration
  
  def change
  
    # Roles
    add_column :roles, :name, :string
    
    # Users
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :user, :password, :string
    
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
    add_column :questions, :style, :string
    add_column :questions, :area, :string

    # Question choice
    add_column :question_choices, :text, :string
    add_column :question_choices, :correct, :boolean

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
