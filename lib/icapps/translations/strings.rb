require 'colorize'

require "icapps/translations/http"

module Icapps
  module Translations
    class Strings
      class << self
        def import
          puts "[VERBOSE] Importing translations from project with key #{options.project_key}".colorize(:white) if options[:verbose]

          languages_json = fetch_languages
          puts "[VERBOSE] There are currently #{languages_json.count} language(s) for this project.".colorize(:white) if options[:verbose]

          languages_json.each { |language| fetch_language_strings_file language }
          puts "[MESSAGE] Finished importing translation.".colorize(:green)
        end

        private

        def options
          ::Icapps::Translations.options
        end

        def config
          ::Icapps::Translations.config
        end

        def fetch_languages
          ::Icapps::Translations::Http.authenticated_response('languages.json', true)
        end

        def fetch_language_strings_file(language)
          short_name = language['short_name']
          puts "[VERBOSE] Fetching #{short_name} translations.".colorize(:white) if options[:verbose]
          string_files = Dir.glob("**/#{short_name}.lproj/#{}")
          if string_files.count == 0
            puts "[WARNING] No 'Localizable.string' file found for the #{short_name} language.".colorize(:yellow)
          elsif string_files.count > 1
            puts "[WARNING] Multiple 'Localizable.string' files found for the #{short_name} language.".colorize(:yellow)
          else
            strings = ::Icapps::Translations::Http.authenticated_response("translations/#{language['id']}.strings")
            write_to_strings_file strings, strings_files, language
          end
        end

        def write_to_strings_file(strings, string_files, language)
          path = string_files.first
          File.open(path, 'w+') { |file| file.puts strings }
          puts "[VERBOSE] Written #{language['short_name']} translations to #{path}.".colorize(:green) if options[:verbose]
        end
      end
    end
  end
end
