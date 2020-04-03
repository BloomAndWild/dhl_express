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
  config.account = ENV.fetch('ACCOUNT')

  config.logger = Logger.new(STDERR)
  config.level = :debug
end
```

## ShipmentRequest

A call to ShipmentRequest service with sample payload:

```ruby
DHLExpress::Operations::ShipmentRequest.new(payload: {
  ClientDetail: {
    # ...
  },
  RequestedShipment: {
    # ...
  }
}).execute
```

If successful will return parsed (from JSON) response body, for example:

```ruby
{
  Notification: [
    {
      # ...
    }
  ],
  PackagesResult: {
    PackageResult: [
      # ...
    ]
  },
  LabelImage: [
    {
      # ...
    }
  ],
  ShipmentIdentificationNumber: 123456789
}
```

## ShipmentDeleteRequest

```ruby
DHLExpress::Operations::ShipmentDeleteRequest.new(payload: {}).execute
```

Example of payload -
```
{
  "PickupDate": "2017-07-24",
  "PickupCountry": "SG",
  "DispatchConfirmationNumber": "SIN-952041",
  "RequestorName": "Terry Kelly",
}
```

A successful call will return parsed (from JSON) response body, for example:

```
{
  "Notification": {
    "@code": "0",
    "Message": "Successfully cancelled"
  }
}
```

## TrackingRequest

A call to TrackingRequest service with sample payload:

```ruby
DHLExpress::Operations::TrackingRequest.new(payload: {
  Request: {
    ServiceHeader: {
      # ...
    }
  },
  AWBNumber: {
    ArrayOfAWBNumberItem: 123456789
  },
  LevelOfDetails: 'ALL_CHECK_POINTS',
  PiecesEnabled: 'B'
}).execute
```

If successful will return parsed (from JSON) response body, for example:

```ruby
{
  Response: {
    ServiceHeader: {
      # ...
    }
  },
  AWBInfo: {
    ArrayOfAWBInfoItem: {
      AWBNumber: 1234567890,
      Status: {
        ActionStatus: 'Success'
      },
      ShipmentInfo: {
        # ...
      }
    }
  }
}
```

## Running specs

To run the specs, add your development credentials to your dev env:
```
SANDBOX_BASE_URL=https://wsbexpress.dhl.com:443/rest/sndpt
SANDBOX_USERNAME=test@test.com
SANDBOX_PASSWORD=password
SANDBOX_ACCOUNT=123456789
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dhl_express.
