# == Schema Information
#
# Table name: medias
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  reference   :string(255)
#  media_type  :string(255)
#

class Media < ActiveRecord::Base

	# References
	belongs_to :owner, polymorphic: true

end