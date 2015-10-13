require "icapps/translations/version"
require "icapps/translations/cli"
require "icapps/translations/import/xcode"
require "icapps/translations/import/gradle"

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

        # Import the files.
        if is_xcode?
          puts "[VERBOSE] Detected an Xcode project.".colorize(:white) if options[:verbose]
          Import::Xcode.import
        elsif is_android?
          puts "[VERBOSE] Detected an Android project with a .gradle file.".colorize(:white) if options[:verbose]
          Import::Gradle.import
        else
          abort '[ERROR] No Xcode or Android gradle file detected.'.colorize(:red) unless @project_key
        end
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
