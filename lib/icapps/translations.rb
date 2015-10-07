require "icapps/translations/version"
require "icapps/translations/cli"
require "icapps/translations/strings"

module Icapps
  module Translations
    class << self
      attr_accessor :options

      def config
        @config ||= Configuration.new
      end

      def import
        # Validate the configuration file. Abort when invalid.
        config.validate

        # Import the strings files.
        Strings.import
      end
    end
  end
end
