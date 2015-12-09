# == Schema Information
#
# Table name: settings
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  preferred_language :integer
#
# Indexes
#
#  index_settings_on_user_id  (user_id)
#

class Setting < ActiveRecord::Base

	belongs_to :user

	LANGUAGES = [
		"en",
		"pt-BR"
	]

	def self.getLanguageIndex(key)
		index = LANGUAGES.index(key)
		if index == nil
			index = 0
		end
		return index
	end

	def preferred_language_key
		if preferred_language >= 0 && preferred_language < LANGUAGES.length 
			return LANGUAGES[preferred_language]
		else
			return "en"
		end
	end

end
