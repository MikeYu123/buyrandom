class PaymentService
  def initialize inplat_id:, id:, amount:
    @inplat_id = inplat_id
    @user = User.find(id)
    @amount = amount
  end

  def call
    @user.transaction do
      unless Payment.find_by_inplat_id(@inplat_id)
        payment = Payment.create(inplat_id: @inplat_id,
                                                               amount: @amount,
                                                               user: @user
        )
        Deposit.create(source: payment,
                       destination: @user,
                       amount: @amount)
        @user.deposit(@amount)
      end
    end
  end
end