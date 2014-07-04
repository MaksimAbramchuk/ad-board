class Operation < ActiveRecord::Base
  
  scope :find_according, ->(advert){ where(advert_id: advert.id).where(user_id: User.current_user.id).where(to: 'declined').last }
  scope :list_all, ->(advert){ where(advert_id: advert.id).order(created_at: :desc) }

  belongs_to :advert
  belongs_to :user
  has_one :comment
end
