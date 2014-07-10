module StateHelper

  class AdvertStatusService
    
    attr_accessor :advert, :user
    
    def initialize(advert, user)
      @advert = advert
      @user = user
    end

    %w(send_for_publication archive publish decline).each do |event|
      define_method(event) do
        before_state = @advert.state
        if @advert.send(event)
          Operation.create(user: @user, from: before_state, to: @advert.state, advert: @advert)
        end
      end
    end
  end

end
