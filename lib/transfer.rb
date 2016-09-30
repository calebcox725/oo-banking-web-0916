require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    self.sender = sender
    self.receiver = receiver
    self.amount = amount
    self.status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if !sender.valid? || sender.balance < amount
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif status == "pending"
      sender.withdrawal(amount)
      receiver.deposit(amount)
      self.status = "complete"
    end
  end

  def reverse_transfer
    if status == "complete"
      receiver.withdrawal(amount)
      sender.deposit(amount)
      self.status ="reversed"
    end
  end
end
