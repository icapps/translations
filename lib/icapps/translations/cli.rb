require 'thor'
require 'colorize'

module Icapps
  module Translations
    class Cli < Thor
      desc 'init', 'Prepare the current folder to use iCapps translations.'
      long_desc <<-LONGDESC
      'init' will generate a .translations configuration file at the location where you run the script. You should do this in the project root.

      You will be able to configure the following parameters:
      \x5> the default .strings filename
      \x5> the default base url

      With --verbose option, some extra loggin is shown.
      LONGDESC
      option :verbose, type: :boolean
      def init
        puts "[VERBOSE] Running the 'translations init command'.".colorize(:white) if options[:verbose]
      end

      desc 'import', 'Import the translations into your project\'s .string files.'
      long_desc <<-LONGDESC
      'import' will overwrite all the matching .strings files in your project. You should do this in the project root.

      With --verbose option, some extra loggin is shown.
      LONGDESC
      option :verbose, type: :boolean
      def import
        puts "[VERBOSE] Running the 'translations import command'.".colorize(:white) if options[:verbose]
      end
    end
  end
end
