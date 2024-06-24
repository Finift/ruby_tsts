RSpec.describe ExchangeIt::Account do
  let(:user_class) {Struct.new(:name, :surname)} #т.к. нам нужен пользак, то создаём заглушку для его имитации
  let(:john) {described_class.new(user_class.new('John', 'Doe'))}
  let(:ann) {described_class.new(user_class.new('Ann', 'Smith'))}

  it 'has zero balance' do
    expect(john.balance).to eq(0)
  end

  it 'has proper uid' do
    expect(john.uid).to be_an_instance_of(String)
    hash = john.hash 'John', 'Doe'
    expect(john.uid).to eq(hash)
  end

  describe '@deposit' do
    it 'allows to deposit correct sum' do
      ann.deposit 30
      expect(ann.balance).to eq(30)
    end

    it 'does not allow to deposit a negative sum' do
      expect{ann.deposit(-130)}.to raise_error(ExchangeIt::IncorrectSum)
    end

    it 'does not allow to deposit a zero sum' do
      expect{ann.deposit(0)}.to raise_error(ExchangeIt::IncorrectSum)
    end
  end
  context 'when performing money withdrawal' do #синоним describe, используем для объединения тестов в группу
    before {john.deposit 100} #положили Джону денег, чтобы было, что списать, благодаря before деньги будем класть перед каждым тестом :each тут идёт по-умолчанию

    specify '#transfer_with_conversion' do
      allow(john).to receive(:convert).
        with(sum: 50, from: :usd, to: :eur).
        and_return(40)
      john.transfer_with_conversion ann, 50, :usd, :eur #заглушка для перевода с конвертацией

      expect(john.balance).to eq(50)
      expect(ann.balance).to eq(40)
      expect(john).to have_received(:convert).once #для проверки того, что метод вызывался
    end
    specify '#transfer' do
      expect(ann.balance).to eq(0) # на начало теста у Энн ничего нет

      john.transfer ann, 30 #Джон переводит Энн 30
      expect(john.balance).to eq(70) #ожидаем, что у него осталось 70, у неё стало 30
      expect(ann.balance).to eq(30)
    end

    # specify '#transfer (mocked)' do
    #   ann_mocked = instance_double('ExchangeIt::Account', balance: 30, deposit: 30)
    #
    #   john.transfer ann_mocked, 30 #Джон переводит Энн 30
    #   expect(john.balance).to eq(70) #ожидаем, что у него осталось 70, у неё стало 30
    #   expect(ann_mocked.balance).to eq(30)
    # end

    describe '#withdraw' do #в контексте вполне можно размещать дескрайб
     it 'allows to withdraw correct sum' do
       john.withdraw 40
       expect(john.balance).to eq(60) #каждый раз джон пересоздаётся под тест!!!
     end

     it 'does not allow to withdraw a sum that is too large' do
       expect{john.withdraw(150)}.to raise_error(ExchangeIt::NotEnoughFunds)
     end

     it 'does not allow to withdraw a negative sum' do
       expect{john.withdraw(-1000)}.to raise_error(ExchangeIt::IncorrectSum)
     end

     it 'does not allow to withdraw a zero sum' do
       expect{john.withdraw(0)}.to raise_error(ExchangeIt::IncorrectSum)
     end
    end
  end
end
