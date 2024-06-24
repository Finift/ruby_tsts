require 'digest' #умеет считать хеши

module ExchangeIt
  module Utils
    module Uid
      def hash(*args)
        return unless args.any?
        Digest::MD5.hexdigest args.join(' ') #создаём хеш MD5 на основе аргументов
      end
    end
  end
end
