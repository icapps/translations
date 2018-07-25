require 'colorize'
require 'yaml'

module Icapps
  module Translations
    class Configuration
      attr_reader :url
      attr_reader :filename
      attr_reader :project_key
      attr_reader :default_language

      class << self
        def create
          if exists?
            puts "[WARNING] Configuration already exists at '#{path}'.".colorize(:yellow)
            return
          end

          File.open(path, 'w') { |f| f.write(initial_content.to_yaml) }
          puts "[MESSAGE] Configuration created at '#{path}'.".colorize(:green)
        end

        def exists?
          File.exist?(path)
        end

        def path
          File.join(Dir.pwd, filename)
        end

        def filename
          '.translations'
        end

        def options
          ::Icapps::Translations.options
        end

        def initial_content
          if ::Icapps::Translations::android?
            android_initial_content
          elsif ::Icapps::Translations::react?
            react_initial_content
          else
            common_initial_content
          end
        end

        def android_initial_content
          common_initial_content.merge!(filename: 'strings.xml',
                                        default_language: 'en')
        end

        def react_initial_content
          common_initial_content.merge!(filename: '*.json',
                                        default_language: 'en')
        end

        def common_initial_content
          {
            url:         'http://your_url.com',
            filename:    'Localizable.strings',
            project_key: 'YourProjectKey'
          }
        end
      end

      def initialize
        read_config if Configuration.exists?
      end

      def validate
        abort '[ERROR] You need to provide a project key in the .translations configuration file.'.colorize(:red) unless @project_key
        abort '[ERROR] You need to provide an url in the .translations configuration file.'.colorize(:red) unless @url
        abort '[ERROR] You need to provide a default filename in the .translations configuration file.'.colorize(:red) unless @filename
      end

      private

      def read_config
        puts "[VERBOSE] Reading the config file at '#{Configuration.path}'.".colorize(:white) if Configuration.options[:verbose]

        params = YAML.load File.open(Configuration.path)
        if params
          @filename         = params[:filename]
          @url              = params[:url]
          @project_key      = params[:project_key]
          @default_language = params[:default_language]
        end
      end
    end
  end
end
