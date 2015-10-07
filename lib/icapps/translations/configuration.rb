require 'colorize'
require 'yaml'

module Icapps
  module Translations
    class Configuration
      attr :url
      attr :filename
      attr :project_key

      class << self
        def create
          if exists?
            puts "[WARNING] Configuration already exists at '#{path}'.".colorize(:yellow)
            return
          end

          File.open(path, "w") { |f| f.write(initial_content.to_yaml) }
          puts "[MESSAGE] Configuration created at '#{path}'.".colorize(:green)
        end

        private

        def exists?
          File.exists?(path)
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

      private

      def read_config
        puts "[VERBOSE] Reading the config file at '#{Configuration.path}'.".colorize(:white) if Configuration.options[:verbose]

        params = YAML::load File.open(Configuration.path)
        if params
          @filename = params[:filename]
          @url = params[:url]
          @project_key = params[:project_key]
        end
      end
    end
  end
end
