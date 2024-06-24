RSpec.describe ExchangeIt::Utils::Uid do
  #это для тестирования создания хешей при отсутствии аргументов(возврат нил)
  let(:dummy) {Class.new {include ExchangeIt::Utils::Uid}.new} #эта заглушка заменяет прямой инклюд метода, т.к. могут наложиться имена

  describe '#hash' do #используем дескрайб для группировки проверок
    it 'returns nil when no args were given' do
      expect(dummy.hash).to be_nil
    end

    it 'returns str when at least 1 arg was given' do
      expect(dummy.hash('str', 'str2')).to be_an_instance_of(String)
    end
  end
end
