require 'colorize'

require "icapps/translations/http"
require "icapps/translations/import/base"

module Icapps
  module Translations
    module Import
      class Gradle < Base
        class << self
          def fetch_language_file(language)
            short_name = language['short_name']
            puts "[VERBOSE] Fetching #{short_name} translations.".colorize(:white) if options[:verbose]

            xml_files = Dir.glob("**/res/values-#{short_name}*/#{config.filename}")
            raise xml_files.inspect

            if string_files.count == 0
              puts "[WARNING] No 'Localizable.string' file found for the #{short_name} language.".colorize(:yellow)
            elsif string_files.count > 1
              puts "[WARNING] Multiple 'Localizable.string' files found for the #{short_name} language.".colorize(:yellow)
            else
              strings = ::Icapps::Translations::Http.authenticated_response("translations/#{language['id']}.strings")
              write_to_strings_file strings, string_files, language
            end
          end

          private

          def write_to_strings_file(strings, string_files, language)
            path = string_files.first
            File.open(path, 'w+') { |file| file.puts strings }
            puts "[VERBOSE] Written #{language['short_name']} translations to #{path}.".colorize(:green) if options[:verbose]
          end
        end
      end
    end
  end
end
