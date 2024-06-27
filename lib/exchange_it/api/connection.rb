module ExchangeIt
  module Api
    module Connection
      BASE_URL = 'https://api.lokalise.com/api2/'

      def connection(client)
        Faraday.new(options(client)) do |faraday|
          faraday.adapter Faraday.default_adapter
        end
      end
    end

    private

    def options(client)
      {
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'ruby-client',
          'X-Api-Token' => client.token
        },
        url: BASE_URL
      }
    end
  end
end
