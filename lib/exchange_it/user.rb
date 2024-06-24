module ExchangeIt
  class User
    extend Forwardable

    attr_reader :name, :surname, :account

    def_delegators :account, :balance

    def initialize(name, surname)
      @name = name
      @surname = surname
      create_account #чтобы каждый раз при создании юзера заводился акк
    end

    private

    def create_account
      @account = Account.new self
    end
  end
end
