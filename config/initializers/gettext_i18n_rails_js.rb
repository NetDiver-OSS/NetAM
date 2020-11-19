# frozen_string_literal: true

module GettextI18nRailsJs
  module Parser
    module Javascript
      # This is required to tell the `rake gettext:find` script to use the Javascript parser for *.vue files.
      def target?(file)
        %w[.js .jsx .vue].include? ::File.extname(file)
      end

      def collect_for(file)
        scan_file = file
        if ::File.extname(file) == '.vue'
          tmp_file = Tempfile.new
          tmp_file.write Nokogiri::HTML.parse(::File.open(file)).at_xpath('//script').children
          tmp_file.rewind

          scan_file = tmp_file.path
        end

        $stdout.puts "Run JavaScript analyser on: #{scan_file}"

        ::File.open(scan_file) do |f|
          f.each_line.each_with_index.collect do |line, idx|
            line.scan(invoke_regex).collect do |function, arguments|
              yield(function, arguments, idx + 1)
            end
          end.inject([], :+).compact
        end
      end
    end
  end
end
