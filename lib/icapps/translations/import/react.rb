require 'colorize'

require 'icapps/translations/http'
require 'icapps/translations/import/base'

module Icapps
  module Translations
    module Import
      class React < Base
        class << self
          def fetch_language_file(language)
            short_name = language['short_name']
            puts "[VERBOSE] Fetching #{short_name} translations.".colorize(:white) if options[:verbose]
            json_files = Dir.glob("labels/#{short_name}.json")

            if json_files.count > 1
              puts "[WARNING] Multiple '#{short_name}.json' files found for the #{short_name} language.".colorize(:yellow)
            else
              json = ::Icapps::Translations::Http.authenticated_response("translations/#{language['id']}.json")
              write_to_file json, json_files, language
            end
          end
        end
      end
    end
  end
end
