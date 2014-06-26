class Advert < ActiveRecord::Base

  scope :more_than_1_day, -> { where(state: "published").where("updated_at <= :day_ago",{day_ago: Time.now - 1.day}) }

  include AASM

  belongs_to :user
  belongs_to :category

  aasm column: "state" do

    state :new, :initial => true
    state :awaiting_publication
    state :declined
    state :published
    state :archived

    event :send_for_publication, :after => :save_state do
      transitions from: [:new, :archived], to: :awaiting_publication
    end

    event :archive, :after => :save_state do
      transitions from: [:new, :awaiting_publication, :declined, :published], to: :archived
    end
    
    event :publish, :after => :save_state do
      transitions :from => :awaiting_publication, :to => :published
    end

    event :decline, :after => :save_state do
      transitions :from => :awaiting_publication, :to => :declined
    end

    event :update, :after => :save_state do
      transitions :from => [:new, :awaiting_publication, :declined, :published], to: :new
    end

  end

  def save_state
    self.save
  end

  def self.archive_old_adverts
    published_adverts = Advert.more_than_1_day
    published_adverts.each { |a| a.archive }
  end

end
