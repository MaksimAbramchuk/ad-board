class Advert < ActiveRecord::Base

  include AASM

  belongs_to :user
  belongs_to :category
  
  aasm column: "state" do

    state :new, :initial => true
    state :awaiting_publication
    state :declined
    state :published
    state :archived

    event :send_for_publication do
      transitions from: [:new, :archived], to: :awaiting_publication
    end

    event :archive do
      transitions from: [:new, :awaiting_publication, :declined, :published], to: :archived
    end
    
    event :publish do
      transitions :from => :awaiting_publication, :to => :published
    end

    event :decline do
      transitions :from => :awaiting_publication, :to => :declined
    end

    event :update do
      transitions :from => [:new, :awaiting_publication, :declined, :published], to: :new
    end

  end

end
