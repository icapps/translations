require "icapps/translations/version"
require "icapps/translations/cli"
require "icapps/translations/import/base"

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
        Import::Base.import
      end

      def is_android?
        Dir.glob("**/*.gradle").count > 0
      end

      def is_xcode?
        Dir.glob("**/*.xcodeproj").count > 0
      end
    end
  end
end
