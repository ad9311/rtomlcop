require_relative '../lib/message'

module Directory
  class FileName
    attr_reader :working_dir, :file_name, :full_dir

    def initialize
      arg = []
      ARGV.each do |a| # Save file name as an arg
        arg << a
      end
      FileName.get_find(arg[0]) # Checks if file exist or if it wasn't input
      @file_name = arg[0]
      @working_dir = Dir.pwd
      @full_dir = "#{@working_dir}/#{@file_name}"
    end
    class << self
      # If file does not exits or file not input then exit script
      def get_find(file_path)
        FileName.no_file(file_path)
        FileName.file_exits?(file_path)
      rescue FileName::NoArgument => e
        Message::Error.no_argument(e.message)
        exit!
      rescue FileName::FileNotExisting => e
        Message::Error.no_such_file(e.message)
        exit!
      end
    end

    def self.file_exits?(arg)
      e = File.exist?(arg)
      raise FileNotExisting unless e
    end

    def self.no_file(arg)
      raise NoArgument if arg.nil?
    end

    class FileNotExisting < StandardError
      def message
        'Invalid file name or file does not exit.'
      end
    end

    class NoArgument < TypeError
      def message
        'File no specified'
      end
    end
  end
end
