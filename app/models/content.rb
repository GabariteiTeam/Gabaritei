# Contents can be created by {User users} (for example, teachers) as additional resources to their
# {Course courses} and/or {Lesson lessons}. By being associated with a {Media media} object, a content can have a wide variety of formats, 
# like PDFs, images, MS Office documents, or even online resources, like YouTube videos.
# They must be associated to a {Subject subject} or a {Field field}, and they can be recommended to one user by
# another user.
# 
# == Schema Information
#
# Table name: contents
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  category_type      :string(255)
#  owner_id           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  name               :string(255)
#  description        :text
#  access_count       :integer
#  download_protected :boolean
#  shareable          :boolean
#
# Indexes
#
#  index_contents_on_category_id_and_category_type  (category_id,category_type)
#  index_contents_on_owner_id                       (owner_id)
#

class Content < ActiveRecord::Base

	# @!attribute name
	# 	Name of the content.
	# 	@return [String] the name of the content.
	#  
	# @!attribute description  
	# 	Description of the content.
	# 	@return [String] the description of the content.
	#
	# @!attribute [r] access_count
	# 	Number of times the content has been accessed.
	# 	@return [Integer] how many times the content has been accessed.
	# 	
	# @!attribute download_protected
	# 	Whether users can or cannot download the content (if it is a file).
	# 	@return [Boolean] "true" if users can download the content, "false" otherwise.

	# @!group Belongs to
	
	# The owner is the {User user} who created the content.
	# @return [User] user who created the content.
	# @see User#contents
	belongs_to :owner, class_name: "User"

	# The category is the {Subject subject} or {Field field} to which the content belongs.
	# @return [Subject, Field] subject or field to which the content belongs.
	# @see Subject#contents
	# @see Field#contents
	belongs_to :category, polymorphic: true
	
	# @!endgroup

	# @!group Has one

	# The {Media media} keeps a file or a reference to an online resource.
	# @return [Media] media object containing a file or a reference to an online resource.
	# @see Media#owner
	has_one :media, as: :owner

	# @!endgroup

	# @!group Has many

	# List of all {Recommendation recommendations} of the content.
	# @return [Array<Recommendation>] all recommendations of the content.
	# @see Recommendation#resource
	has_many :recommendations, as: :resource

	# List of all {Course courses} that have access to the content.
	# @return [Array<Course>] all courses that have access to the content.
	# @see Course#contents
	has_many :courses, through: :course_contents

	# List of all {Lesson lessons} that have access to the content.
	# @return [Array<Lesson>] all lessons that have access to the content.
	# @see Lesson#contents
	has_many :lessons, through: :lesson_contents

	# @!endgroup

	has_many :course_contents
	has_many :lesson_contents

end
