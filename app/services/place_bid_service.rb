class PlaceBidService
  def initialize(auction:, user:, amount: )
    @auction = auction
    @user = user
    @amount = amount.to_d
  end

  def call
    @auction.transaction do
      if @auction.active?
        if @user.has_enough_to_bid? @amount
          if @amount >= @auction.minimal_bid && @amount <= @auction.target_amount
            Bid.create(amount: @amount, source: @user, destination: @auction)
            @user.withdraw(@amount)
            @auction.deposit(@amount)
            if @auction.current_amount > @auction.target_amount
              @auction.update(expires_at: [@auction.expires_at, DateTime.now + 1.day].max)
            end
            true
          else
            raise IncorrectAmountError, 'Incorrect amount'
          end
        else
          raise InsufficientFundsError, 'Not enough funds'
        end
      else
        raise InactiveAuctionError, 'Inactive auction'
      end
    end
  end

  class IncorrectAmountError < StandardError ; end
  class InsufficientFundsError < StandardError ; end
  class InactiveAuctionError < StandardError ; end
end