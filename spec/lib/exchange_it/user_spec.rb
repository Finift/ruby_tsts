RSpec.describe ExchangeIt::User do #описание, какой класс тестируем
  let(:user) {|ex| described_class.new(ex.metadata[:name] || 'John', 'Doe')} #объявили юзера, чтобы не создавать в каждом тесте, если после нейм дописать || 'John', 'Doe', то будет подставлять эти имена по-умолчанию
  let(:user_no_name){described_class.new nil, 'Doe'}
  #let(:user_no_name){described_class.new nil, 'Doe'} #described_class - вместо повтора ExchangeIt::User - не используем, т.к. подключили метаданные
#вышесозданные методы пересоздают юзера для каждого теста
 it 'returns name', :fast do
   expect(user.name).to eq('John') #то, что мы ожидаем увидеть
   expect(user.name).to be_an_instance_of(String)
 end

 it 'returns name as a string', :fast do |ex|
   puts ex.metadata.inspect #позволит показать метаданные прям в тесте(начинаем с |ex|)
   expect(user_no_name.name).to be_an_instance_of(String) #проверка, что возвращается стринга
 end

 fit 'returns surname' do
   expect(user.surname).to eq('Doe') #то, что мы ожидаем увидеть
   expect(user.surname).to be_an_instance_of(String)
 end
 fit 'has account' do
   expect(user.account).to be_an_instance_of(ExchangeIt::Account)
 end
 #синонимы для it "" do
 example '...' do #позволяет проверить разные входные значения, см.ниже
 end
 describe '#some_method' do
   example 'value1' do
   end
   example 'value2' do
   end
 end
#и
specify '#account' do #решётка обозначает, что тестируем метод образца класса, если метод класса, то поставим точку вместо неё
end
#можно использовать fit,fdescribe,fcontex или fspecify - это делает тесты более приоритетными
 it 'has zero balance by default' do
  expect(user.balance).to eq(0)
 end
end
