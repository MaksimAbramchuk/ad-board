class AdvertStatusService
  attr_accessor :advert, :user

  def initialize(advert, user)
    @advert = advert
    @user = user
  end

  [:send_for_publication, :archive, :publish, :decline].each do |event|
    define_method(event) do
      ActiveRecord::Base.transaction do
        before_state = @advert.state
        @advert.send(event)
        Operation.create(user: @user, from: before_state, to: @advert.state, advert: @advert)
      end
    end
  end
end
