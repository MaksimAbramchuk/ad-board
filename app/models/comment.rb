class Comment < ActiveRecord::Base
  belongs_to :advert
  belongs_to :operation
end
