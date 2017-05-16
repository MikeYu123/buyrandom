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
          if @amount >= 0
            Operation.create(amount: @amount, source: @user, destination: @auction)
            @user.widthraw(@amount)
            @auction.deposit(@amount)
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