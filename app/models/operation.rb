class Operation < ActiveRecord::Base
  belongs_to :advert
  belongs_to :user
  has_one :comment
end
