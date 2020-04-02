# frozen_string_literal: true

require 'logger'

def configure_client(base_url: nil, username: nil, password: nil)
  DHLExpress::Client.configure do |config|
    config.base_url = base_url || ENV.fetch('SANDBOX_BASE_URL')
    config.username = username || ENV.fetch('SANDBOX_USERNAME')
    config.password = password || ENV.fetch('SANDBOX_PASSWORD')
    config.account = password || ENV.fetch('SANDBOX_ACCOUNT')

    config.logger = Logger.new(STDERR)
    config.logger.level = :debug
  end
end
