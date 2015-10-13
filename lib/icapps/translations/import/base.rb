require 'colorize'

require "icapps/translations/http"

module Icapps
  module Translations
    module Import
      class Base
        class << self
          def import
            puts "[VERBOSE] Importing translations from project with key #{options.project_key}".colorize(:white) if options[:verbose]

            languages_json = fetch_languages
            puts "[VERBOSE] There are currently #{languages_json.count} language(s) for this project.".colorize(:white) if options[:verbose]

            languages_json.each { |language| fetch_language_file language }
            puts "[MESSAGE] Finished importing translation.".colorize(:green)
          end

          def options
            ::Icapps::Translations.options
          end

          def config
            ::Icapps::Translations.config
          end

          def fetch_languages
            ::Icapps::Translations::Http.authenticated_response('languages.json', true)
          end

          def write_to_file(content, files, language)
            File.open(files.first, 'w+') { |file| file.puts content }
            puts "[VERBOSE] Written #{language['short_name']} translations to #{files.first}.".colorize(:green) if options[:verbose]
          end
        end
      end
    end
  end
end
