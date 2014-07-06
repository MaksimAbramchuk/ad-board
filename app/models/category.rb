class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :adverts

  before_destroy :check_adverts

  protected

  def check_adverts
    return false unless self.adverts.empty?
  end

end
