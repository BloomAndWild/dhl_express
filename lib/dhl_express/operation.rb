# frozen_string_literal: true

module DHLExpress
  class Operation
    include Errors

    DEFAULT_HEADERS = {
      content_type: 'application/json'
    }.freeze

    def initialize(**options)
      @options = options
    end

    def execute
      http_client = Faraday.new
      http_client.basic_auth(username, password)

      response = http_client.run_request(http_method, endpoint, json_payload, headers)
      body = JSON.parse(response.body, symbolize_names: true)
      return body if response.success?

      raise ResponseError.new(payload: payload, body: body, status: response.status)
    end

    protected

    def http_method
      :post
    end

    def service
      raise AbstractMethodError
    end

    private

    attr_reader :options

    def endpoint
      "#{base_url}/#{service}"
    end

    def json_payload
      JSON.generate(payload)
    end

    def headers
      DEFAULT_HEADERS.merge(options.fetch(:headers, {}))
    end

    def payload
      options[:payload]
    end

    def username
      config.username
    end

    def password
      config.password
    end

    def base_url
      config.base_url
    end

    def config
      Client.config
    end
  end
end
