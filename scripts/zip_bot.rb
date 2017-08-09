$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'zip'
require 'dotenv'

Dotenv.load!

class ZipBot

    def initialize(input_dir)
      @input_dir = input_dir
      @output_file = "#{(ENV['SHARE_FOLDER'] || '../')}#{(ENV['BOT_NAME'] || 'bot')}.zip"
    end

    def write
      entries = Dir.entries(@input_dir) - %w(. .. .git demo scripts .env .end .gitignore Gemfile Gemfile.lock README.md .ruby-version .DS_Store)

      ::Zip::File.open(@output_file, ::Zip::File::CREATE) do |io|
        write_entries entries, '', io
      end
    end

    private

    def write_entries(entries, path, io)
      entries.each do |e|
        zip_file_path = path == '' ? e : File.join(path, e)
        disk_file_path = File.join(@input_dir, zip_file_path)
        puts "Deflating #{disk_file_path}"

        if File.directory? disk_file_path
          recursively_deflate_directory(disk_file_path, io, zip_file_path)
        else
          put_into_archive(disk_file_path, io, zip_file_path)
        end
      end
    end

    def recursively_deflate_directory(disk_file_path, io, zip_file_path)
  
      unless File.directory? zip_file_path
        io.mkdir zip_file_path
      end
      subdir = Dir.entries(disk_file_path) - %w(. ..)
      write_entries subdir, zip_file_path, io
    end

    def put_into_archive(disk_file_path, io, zip_file_path)
      io.get_output_stream(zip_file_path) do |f|
        f.write(File.open(disk_file_path, 'rb').read)
      end
    end

end

mode = ARGV[0] || 'update'
zip_generator = ZipBot.new('.')

if mode == 'prepare'
  zip_generator.write
end

puts "Done! zip file of your bot is now on #{(ENV['SHARE_FOLDER'] || '../')}#{(ENV['BOT_NAME'] || 'bot')}.zip"

