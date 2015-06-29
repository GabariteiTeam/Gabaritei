class CreateModelRelations < ActiveRecord::Migration
  
  def change
    
    create_table :registration_requests do |t|
      t.timestamps null:false
    end

    create_table :medias do |t|
      t.timestamps null: false
    end

    create_table :roles do |t|
      t.timestamps null:false
    end

    create_table :permissions do |t|
      t.timestamps null:false
    end

    create_table :subjects do |t|
      t.timestamps null: false
    end

    create_table :fields do |t|
      t.belongs_to :subject, index: :true, required: true
      t.timestamps null: false
    end

    create_table :users do |t|
      t.belongs_to :media, index: true
      t.timestamps null:false
    end

    create_table :courses do |t|
      t.references :category, polymorphic: true, index: true, required: true
      t.timestamps null: false
    end

    create_table :questions do |t|
      t.belongs_to :user, index: true, required: true
      t.timestamps null: false
    end

    create_table :question_choices do |t|
      t.belongs_to :question, index: true, required: true
      t.timestamps null: false
    end

    create_table :course_registration_requests do |t|
      t.belongs_to :user, index: true, required: true
      t.belongs_to :course, index: true, required: true
      t.timestamps null:false
    end

    create_table :course_news do |t|
      t.belongs_to :user, index: true, required: true
      t.belongs_to :course, index: true, required: true
      t.timestamps null: false
    end

    create_table :user_deficit_categories, id: false do |t|
      t.belongs_to :user, index: true, required: true
      t.references :category, polymorphic: true, index: true, required: true
      t.timestamps null: false
    end

    create_table :user_roles, id: false do |t|
      t.belongs_to :user, index: true, required: true
      t.belongs_to :role, index: true, required: true
      t.timestamps null:false
    end

    create_table :role_permissions, id: false do |t|
      t.belongs_to :role, index: true, required: true
      t.belongs_to :permission, index: true, required: true
      t.timestamps null:false
    end

    create_table :question_medias, id: false do |t|
      t.belongs_to :media, index: true, required: true
      t.belongs_to :question, index: true, required: true
      t.timestamps null: false
    end

    create_table :question_categories, id: false do |t|
      t.belongs_to :question, index: true, required: true
      t.references :category, polymorphic: true, index: true, required: true
      t.timestamps null: false
    end

    create_table :ratings, id: false do |t|
      t.belongs_to :user, index: true, required: true
      t.belongs_to :question, index: true, required: true
      t.timestamps null: false
    end
    
    create_table :course_questions, id: false do |t|
      t.belongs_to :question, index: true, required: true
      t.belongs_to :course, index: true, required: true
      t.timestamps null: false
    end
    
    create_table :responses do |t|
      t.belongs_to :question, index: true, required: true
      t.belongs_to :user, index: true, required: true
      t.timestamps null: false
    end

    create_table :response_choices do |t|
      t.belongs_to :response, index: true, required: true
      t.belongs_to :question_choices, required: true
      t.timestamps null: false
    end
    
    create_table :tests do |t|
      t.belongs_to :course, index: true, required: true
      t.belongs_to :user, index: true, required: true
      t.timestamps null: false
    end

    create_table :test_questions, id: false do |t|
      t.belongs_to :test, index: true, required: true
      t.belongs_to :question, index: true, required: true
      t.timestamps null: false
    end

    create_table :test_responses, id: false do |t|
      t.belongs_to :test, index: true, required: true
      t.belongs_to :response, index: true, required: true
      t.timestamps null: false
    end
    
    create_table :user_course_roles, id: false do |t|
      t.belongs_to :user, index: true, required: true
      t.belongs_to :course, index: true, required: true
      t.string :role, required: true
      t.timestamps null: false
    end

    create_table :recommendations do |t|
      t.belongs_to :user_source, index: true, required: true
      t.belongs_to :user_destination, index: true, required: true
      t.references :resource, polymorphic: true, index: true, required: true
      t.timestamps null: false
    end

    create_table :contents do |t|
      t.references :category, polymorphic: true, index: true, required: true
      t.belongs_to :user, index: true, required: true
      t.belongs_to :media, index: true, required: true
      t.timestamps null: false
    end

    create_table :course_contents, id: false do |t|
      t.belongs_to :course, index: true, required: true
      t.belongs_to :contents, index: true, required: true
      t.timestamps null: false
    end
   
  end
  
end
