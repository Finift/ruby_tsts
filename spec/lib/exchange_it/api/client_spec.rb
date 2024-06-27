RSpec.describe ExchangeIt::Api::Client do
  let(:test_client) {described_class.new(ENV.fetch('LOCALISE_API_TOKEN'){'fake'})}
  let(:project_id) {'123.abc'}

  specify '#project' do
    stub_request(:get, "https://api.lokalise.com/api2/projects/123.abc").
        with(
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip:q=1.0,deflate;1=0.6,identity;q=0.3',
            'User-Agent'=>'ruby-client',
            'X-Api-Token'=>'123.abc'
          }).
        to_return(status: 200, body: "", headers: {})
    project = test_client.project project_id
  end
end
