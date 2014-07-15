class Category < ActiveRecord::Base

  validates :name, presence: true
  has_many :adverts, dependent: :restrict_with_error

end
