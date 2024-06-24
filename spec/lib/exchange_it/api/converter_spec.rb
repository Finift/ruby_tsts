RSpec.describe ExchangeIt::Api::Converter do
  specify '#convert' do
    #converter_stub = double.as_null_object - при таком раскладе будет отвечать на любые методы
    converter_stub = double 'ExchangeIt::Api::Converter'#, convert: 100 #мы можем отправлять метод convert, который всегда будет возвращать 100
#или вместо , convert: 100
    allow(converter_stub).to receive(:convert).with(sum: 80).and_return(100) #буквально разрешаю принимать метод и возвращать 100, with не обязательно, он аргументы передаёт, с ним тест ниже уадёт, т.к. др.аргументы
    #expect(converter_stub.convert(123, "test")).to eq(100) #123? "test" - можно любые аргументы передать, всё равно, вернёт 100
  end
end
#allow не вызывает ошибки, если метод так и не вызовет, а вот если перед ним поместить expect(converter_stub).to receive(:convert), то надо хоть раз да вызвать, иначе ошибка
# можно последним ещё записать:
#expect(converter_stub).to have_received(:convert).
#  with(sum: 80).once - это означает, что я жду, что метод будет вызван с параметром 80 хотя бы один раз, twice, at_least(5).times


#если заменить на converter_stub = instance_double 'ExchangeIt::Api::Converter', то перестанет срабатывать в случаях, когда метод convert и вовсе не прописан
