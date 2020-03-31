# frozen_string_literal: true

module DHLExpress
  class Operation
    include Errors

    def initialize(**options)
      @options = options
    end

    def execute
      connection = Faraday.new
      connection.basic_auth(username, password)

      connection.run_request(http_method, endpoint, json_payload, headers)
    end

    protected

    def http_method
      raise AbstractMethodError
    end

    def endpoint
      raise AbstractMethodError
    end

    private

    attr_reader :options

    def username
      config.username
    end

    def password
      config.password
    end

    def config
      Client.config
    end

    def json_payload
      JSON.generate(options[:payload])
    end
  end
end
