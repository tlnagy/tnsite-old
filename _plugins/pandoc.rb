require 'open3'

module Jekyll
  module Converters
    class Markdown < Converter
      safe true

      pygments_prefix "\n"
      pygments_suffix "\n"

      def setup
        return if @setup
        @parser = case @config['markdown']
          when 'redcarpet'
            RedcarpetParser.new @config
          when 'kramdown'
            KramdownParser.new @config
          when 'rdiscount'
            RDiscountParser.new @config
          when 'maruku'
            MarukuParser.new @config
          when 'pandoc'
            PandocParser.new @config
          else
            STDERR.puts "Invalid Markdown processor: #{@config['markdown']}"
            STDERR.puts " Valid options are [ maruku | rdiscount | kramdown ]"
            raise FatalException.new("Invalid Markdown process: #{@config['markdown']}")
        end
        @setup = true
      end

      def matches(ext)
        rgx = '(' + @config['markdown_ext'].gsub(',','|') +')'
        ext =~ Regexp.new(rgx, Regexp::IGNORECASE)
      end

      def output_ext(ext)
        ".html"
      end

      def convert(content)
        setup
        @parser.convert(content)
      end
    end
  end
end

module Jekyll
  module Converters
    class Markdown
      class PandocParser
        def initialize(config)
          @config = config
        end


        def convert(content)
          flags  = @config['pandoc']['flags']
          output = ''
          Open3::popen3("pandoc -t html5 #{flags}") do |stdin, stdout, stderr|
            stdin.puts content
            stdin.close
            output = stdout.read.strip
          end
          output
        end

        def config_option(key, default=nil)
          case @config['pandoc']
            when nil then default
            else @config['pandoc'].fetch(key, default)
          end
        end
      end
    end
  end
end