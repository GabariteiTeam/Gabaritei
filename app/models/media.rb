# == Schema Information
#
# Table name: medias
#
#  id            :integer          not null, primary key
#  owner_id      :integer
#  owner_type    :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  reference     :string(255)
#  is_attachment :boolean
#
# Indexes
#
#  index_medias_on_owner_id_and_owner_type  (owner_id,owner_type)
#

class Media < ActiveRecord::Base

	# @!attribute reference
	# 	Reference to an online resource. This attribute is only taken into account
	# 	if the attribute {Media#is_attachment is_attachment} is false.
	# 	@return [String] the URL to the online resource.
	#
	# @!attribute is_attachment
	# 	This attribute is true if the media object is an attachment (uploaded file) or false if it is a reference to an online resource.
	# 	@return [Boolean] "true" if the media object has an attachment, "false" 
	# 	 if it just references an online resource.
	#
	# @!attribute data
	# 	This attribute references an uploaded file in case the media is an attachment.
	# 	@return [File] the media file.
	has_attached_file :data

	# @!group Belongs to

	# The owner is the entity that possesses the media. Any entity can possess media objects, as long as they reference this model as "owner".
	# @return The object which possesses the media object.
	belongs_to :owner, polymorphic: true

	# @!endgroup

end
