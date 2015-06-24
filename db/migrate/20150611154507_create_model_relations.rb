class CreateModelRelations < ActiveRecord::Migration
  
  def change
    
    create_table :roles do |t|
      t.timestamps null:false
    end
    
    create_table :users do |t|
      t.belongs_to :role, index: true
      t.timestamps null:false
    end
    
    create_table :subjects do |t|
      t.timestamps null: false
    end
    
    create_table :contents do |t|
      t.belongs_to :subject, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
    
    create_table :courses do |t|
      t.belongs_to :subject, index: true
      t.timestamps null: false
    end
    
    create_table :user_course_roles, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      t.string :role
      t.timestamps null: false
    end
    
    create_table :questions do |t|
      t.belongs_to :user, index: true
      t.timestamps null: false
    end

    create_table :question_choices do |t|
      t.belongs_to :question, index: true
      t.timestamps null: false
    end
    
    create_table :question_subjects, id: false do |t|
      t.belongs_to :question, index: true
      t.belongs_to :subject, index: true
      t.timestamps null: false
    end
    
    create_table :ratings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true
      t.timestamps null: false
    end
    
    create_table :course_questions, id: false do |t|
      t.belongs_to :question, index: true
      t.belongs_to :course, index: true
      t.timestamps null: false
    end
    
    create_table :responses do |t|
      t.belongs_to :question, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
    
    create_table :tests do |t|
      t.belongs_to :course, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end

    create_table :test_response, id: false do |t|
      t.belongs_to :response, index: true
      t.belongs_to :test, index: true
      t.timestamps null: false
    end
    
    create_table :question_tests, id: false do |t|
      t.belongs_to :test, index: true
      t.belongs_to :question, index: true
      t.timestamps null: false
    end
    
  end
  
end
