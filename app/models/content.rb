# == Description
#
# Contents can be created by {User users} (for example, teachers) as additional resources to their {Course courses}.
# By being associated with a {Media} object, a content can have a wide variety of formats, like PDFs, 
# images, MS Office documents, or even online resources, like YouTube videos. They must be associated to a {Subject subject}
# or a {Field field}, and they can be recommended to one {User user} by another {User user}.
#
# == Schema Information
#
# Table name: contents
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  category_type      :string(255)
#  user_id            :integer
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
#  index_contents_on_user_id                        (user_id)
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
	
	# @!method owner
	# 	The owner is the {User user} who created the content.
	# 	@return [User] user who created the content.
	belongs_to :owner, class_name: "User"

	# @!method category
	# 	The category is the {Subject subject} or {Field field} to which the content belongs.
	# 	@return [Subject, Field] subject or field to which the content belongs.
	belongs_to :category, polymorphic: true
	
	# @!endgroup

	# @!group Has one

	# @!method media
	# 	The {Media media} keeps a file or a reference to an online resource.
	# 	@return [Media] media object containing a file or a reference to an online resource.
	has_one :media, as: :owner

	# @!endgroup

	# @!group Has many

	# @!method recommendations
	# 	List of all {Recommendation recommendations} of the content.
	# 	@return [Array<Recommendation>] all recommendations of the content.
	has_many :recommendations, as: :resource

	# @!method courses
	# 	List of all {Course courses} that have access to the content.
	# 	@return [Array<Course>] all courses that have access to the content.
	has_many :courses, through: :course_contents

	# @!endgroup

	has_many :course_contents

end
