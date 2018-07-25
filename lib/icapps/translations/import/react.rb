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
          end
        end
      end
    end
  end
end
