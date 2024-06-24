require_relative '../lib/exchange_it'

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/specs.txt' # тут будет инфа о неудачных прогонах
end
