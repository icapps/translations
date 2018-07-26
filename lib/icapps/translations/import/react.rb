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
            json_files = retrieve_file(short_name)

            if json_files.count > 1
              puts "[WARNING] Multiple '#{short_name}.json' files found for the #{short_name} language.".colorize(:yellow)
            else
              json = ::Icapps::Translations::Http.authenticated_response("translations/#{language['id']}.json")
              write_to_file json, json_files, language
            end
          end

          def retrieve_file(language)
            json_files = Dir.glob("labels/#{language}.json")
            unless json_files.count == 0
              return json_files
            end

            puts "[VERBOSE] Check if #{default_directory} exists.".colorize(:white) if options[:verbose]
            unless File.directory?(default_directory)
              puts "[VERBOSE] Creating '#{default_directory}'.".colorize(:white) if options[:verbose]
              FileUtils.mkdir_p(default_directory)
            end

            puts "[VERBOSE] Creating '#{language}.json'.".colorize(:white) if options[:verbose]
            File.open("#{default_directory}/#{language}.json", "w") {}
            
            puts "[VERBOSE] Rescan the project.".colorize(:white) if options[:verbose]
            return Dir.glob("#{default_directory}/#{language}.json")
          end

          def default_directory
            "labels"
          end
        end
      end
    end
  end
end
