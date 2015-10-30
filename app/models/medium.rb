# A medium is an object which keeps a file or a reference to an online resource. It can be integrated and rendered
# in several different ways, depending on the context.
#
# == Schema Information
#
# Table name: media
#
#  id                :integer          not null, primary key
#  owner_id          :integer
#  owner_type        :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reference         :string(255)
#  is_attachment     :boolean
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#
# Indexes
#
#  index_media_on_owner_id_and_owner_type  (owner_id,owner_type)
#

class Medium < ActiveRecord::Base

	# @!attribute reference
	# 	Reference to an online resource. This attribute is only taken into account
	# 	if the attribute {Medium#is_attachment is_attachment} is false.
	# 	@return [String] the URL to the online resource.
	#
	# @!attribute is_attachment
	# 	This attribute is true if the medium object is an attachment (uploaded file) or false if it is a reference to an online resource.
	# 	@return [Boolean] "true" if the medium object has an attachment, "false" 
	# 	 if it just references an online resource.
	#
	# @!attribute data
	# 	This attribute references an uploaded file in case the medium is an attachment.
	# 	@return [File] the medium file.
	has_attached_file :data
	do_not_validate_attachment_file_type :data

	# @!group Belongs to

	# The owner is the entity that possesses the medium. Any entity can possess medium objects, as long as they reference this model as "owner".
	# @return The object which possesses the medium object.
	# @see Content#medium
	# @see Question#media
	belongs_to :owner, polymorphic: true

	# @!endgroup

end
