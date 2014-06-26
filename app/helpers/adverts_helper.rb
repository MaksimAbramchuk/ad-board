module AdvertsHelper
	def available_states_for advert
		available = []
		if current_user.send(:admin?)
		  if advert.awaiting_publication?
		    available = [:publish, :decline]
		  elsif advert.published? || advert.declined?
		    available = [:archive]
		  end
		elsif advert.awaiting_publication?
		  available << [:archive]
		elsif advert.new?
		  available << [:send_for_publication, :archive]
		end
	    
		if advert.archived? 
	      available << [:send_for_publication]
		end

		available
	end
end
