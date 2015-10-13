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

            file_path = "app/src/main/res/#{values_name(short_name)}/#{config.filename}"
            xml_files = Dir.glob(file_path)

            if xml_files.count == 0
              puts "[WARNING] No '#{file_path}' file found for the #{short_name} language.".colorize(:yellow)
            elsif xml_files.count > 1
              puts "[WARNING] Multiple '#{file_path}' files found for the #{short_name} language.".colorize(:yellow)
            else
              xml = ::Icapps::Translations::Http.authenticated_response("translations/#{language['id']}.xml")
              write_to_file xml, xml_files, language
            end
          end

          private

          def values_name(short_name)
            if short_name == 'en'
              # Default language is English.
              'values'
            else
              # Android requires the country code to be prefixed with an 'r'.
              # ex. nl-BE becomes nl-rBE
              "values-#{short_name.gsub('-', '-r')}"
            end
          end
        end
      end
    end
  end
end
