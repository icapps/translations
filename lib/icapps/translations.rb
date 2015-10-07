require "icapps/translations/version"
require "icapps/translations/cli"

module Icapps
  module Translations
    class << self
      attr_accessor :options

      def config
        @config ||= Configuration.new
      end
    end
  end
end
