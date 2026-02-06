class InsufficientFundsError < StandardError; end

class BankAccount
  attr_reader :owner, :balance
  
  def initialize(owner, balance=0)
    @owner = owner
    @balance = balance
  end

  def deposit(amount)
    amount_validation(amount)
    @balance += amount
  end

  def withdraw(amount)
    amount_validation(amount)
    raise InsufficientFundsError if amount > balance
    @balance -= amount
  end

  def to_s
    # "#{owner}: £#{balance}"
    format("%s: £%.2f", owner, balance)
  end

  private
  def amount_validation(amount)
    raise ArgumentError if amount <= 0
  end
end

class SavingsAccount < BankAccount
  attr_accessor :withdrawal_fee

  def initialize(owner, balance, withdrawal_fee=1.5)
    super(owner, balance)
    @withdrawal_fee = withdrawal_fee
  end

  def withdraw(amount)
    super(amount+withdrawal_fee)
  end
end

class CheckingAccount < BankAccount
  attr_accessor :overdraft_limit

  def initialize(owner, balance, overdraft_limit=100.00)
    super(owner, balance)
    @overdraft_limit = overdraft_limit
  end

  def withdraw(amount)
    amount_validation(amount)
    available = balance + overdraft_limit
    raise InsufficientFundsError if amount > available
    @balance -= amount
  end
end