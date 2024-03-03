class RoutesLocationsClient
    include Waterfall

    def initialize(url:, method:)
      @url = url
      @method = method
    end
    
    def call
      chain { @result = request_call(url: @url, method: @method, headers: @headers) }
      when_falsy { @result.success? }
        .dam { @result.error[:message] }
      chain(:output) { @result.response }
    end

    private

    def request_call(url:, method:, headers: {})
      RestClient::Request.execute(method: method, url: url)
      options = { url: url, method: method, headers: headers }
      result = RestClient::Request.execute(options)
      construct_output(JSON.parse(result))
    rescue StandardError => e
      handle_error(e, result.to_h)
      construct_error_output(message: e.message, type: 'request_call function call')
    end

    def construct_output(result)
      output = {
        success?: true,
        response: result
      }
      OpenStruct.new(output)
    end

    def construct_error_output(message:, type:)
      output = {
        success?: false,
        error: {
          message: message,
          type: type
        }
      }
      OpenStruct.new(output)
    end

    def handle_error(error, current_user, obj = {})
      # To Be Implemented - Send the error messages to sentry
      Rails.logger.error(error)
    end
end