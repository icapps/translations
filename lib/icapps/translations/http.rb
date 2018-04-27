require 'colorize'
require 'net/http'
require 'json'
require 'openssl'

module Icapps
  module Translations
    class Http
      class << self
        def authenticated_response(path, is_json = false)
          OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

          uri = URI("#{config.url}/#{path}")
          puts "[VERBOSE] Connecting to url '#{uri}'.".colorize(:white) if options[:verbose]

          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = uri.scheme == 'https'
          request =  Net::HTTP::Get.new(uri)
          request.add_field 'Authorization', "Token token=#{config.project_key}"
          response = http.request(request)
          is_json ? JSON.parse(response.body) : response.body
        end

        private

        def options
          ::Icapps::Translations.options
        end

        def config
          ::Icapps::Translations.config
        end
      end
    end
  end
end
