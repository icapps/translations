require 'icapps/translations/version'
require 'icapps/translations/cli'
require 'icapps/translations/import/react'
require 'icapps/translations/import/xcode'
require 'icapps/translations/import/gradle'

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
        if react?
          puts '[VERBOSE] Detected an React project with a package.json file.'.colorize(:white) if options[:verbose]
          Import::React.import
        elsif xcode?
          puts '[VERBOSE] Detected an Xcode project.'.colorize(:white) if options[:verbose]
          Import::Xcode.import
        elsif android?
          puts '[VERBOSE] Detected an Android project with a .gradle file.'.colorize(:white) if options[:verbose]
          Import::Gradle.import
        else
          abort '[ERROR] No Xcode, Android gradle, React package file detected.'.colorize(:red) unless @project_key
        end
      end

      def android?
        Dir.glob('**/*.gradle').count > 0
      end

      def xcode?
        Dir.glob('**/*.xcodeproj').count > 0
      end

      def react?
        Dir.glob('**/package.json').count > 0
      end
    end
  end
end
