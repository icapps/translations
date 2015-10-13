require 'colorize'

require "icapps/translations/http"
require "icapps/translations/import/base"

module Icapps
  module Translations
    module Import
      class Xcode < Base
        class << self
          def fetch_language_file(language)
            short_name = language['short_name']
            puts "[VERBOSE] Fetching #{short_name} translations.".colorize(:white) if options[:verbose]
            string_files = Dir.glob("**/#{short_name}.lproj/#{config.filename}")
            if string_files.count == 0
              puts "[WARNING] No 'Localizable.string' file found for the #{short_name} language.".colorize(:yellow)
            elsif string_files.count > 1
              puts "[WARNING] Multiple 'Localizable.string' files found for the #{short_name} language.".colorize(:yellow)
            else
              strings = ::Icapps::Translations::Http.authenticated_response("translations/#{language['id']}.strings")
              write_to_file strings, string_files, language
            end
          end
        end
      end
    end
  end
end
