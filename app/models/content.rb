class Content < ActiveRecord::Base
  
	# References
	belongs_to :user
	belongs_to :category, polymorphic: true
	belongs_to :media

	# Referenced by
	has_many :recommendations, as: :resource
	has_many :course_contents

end
