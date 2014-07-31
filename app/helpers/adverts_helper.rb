module AdvertsHelper
  def available_states_for(advert)
    available = []
    if current_user.admin?
      if advert.awaiting_publication?
        available = [:decline, :publish]
      elsif advert.published? || advert.declined?
        available = [:archive]
      end
    elsif advert.published? || advert.declined?
      available << [:archive]
    end
    if advert.awaiting_publication?
      available << [:archive]
    end
    if advert.new?
      available << [:send_for_publication, :archive]
    end
    if advert.archived?
    available << [:send_for_publication]
    end
    available.flatten
  end

  def formatted_time_from_now(advert)
    " about #{distance_of_time_in_words(Time.now-advert.created_at)} ago"
  end
end
