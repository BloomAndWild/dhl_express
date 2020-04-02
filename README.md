# DhlExpress

Ruby wrapper for DHL Express Rest API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "dhl_express", branch: "master", github: "BloomAndWild/dhl_express"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dhl_express

## Usage

#### Configure client

```ruby
DHLExpress::Client.configure do |config|
  config.base_url = ENV.fetch('BASE_URL')
  config.username = ENV.fetch('USERNAME')
  config.password = ENV.fetch('PASSWORD')

  config.logger = Logger.new(STDERR)
  config.level = :debug
end
```

## ShipmentRequest

TBD

## ShipmentDeleteRequest

```ruby
DHLExpress::Operations::ShipmentDeleteRequest.new(payload: {}).execute
```

Example of payload -
```
{
  "PickupDate" => "2017-07-24",
  "PickupCountry" => "SG",
  "DispatchConfirmationNumber" => "SIN-952041",
  "RequestorName" => "Terry Kelly",
  "Reason" => "001",
}
```

## TrackingRequest

TBD

## Running specs

To run the specs, add your development credentials to your dev env:
```
SANDBOX_BASE_URL=https://wsbexpress.dhl.com:443/rest/sndpt
SANDBOX_USERNAME=test@test.com
SANDBOX_PASSWORD=password
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dhl_express.
