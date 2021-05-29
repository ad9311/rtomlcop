require_relative '../lib/message'

# Dedicated module to handle directory accessing.
module Directory
  class FileName
    attr_reader :args, :files, :full_dir

    def initialize
      @args = []
      @files = []
      @full_dir = []
      ARGV.each do |arg|
        @args << arg
      end
      mode
    end

    private

    def mode
      if @args[0] == '--all'
        find_files
      else
        check_for_file
      end
    end

    def find_files
      Dir.glob('*.toml').each do |f|
        @files << f
      end
      if @files.length.zero?
        Message::Warning.no_files
        exit!
      end
      dir = Dir.pwd
      @files.length.times do |d|
        @full_dir << "#{dir}/#{@files[d]}"
      end
    end

    def check_for_file
      no_file
      file_exits?
      if /\.toml$/.match?(@args[0])
        dir = Dir.pwd
        @files[0] = @args[0]
        @full_dir[0] = "#{dir}/#{@files[0]}"
      else
        @files[0] = @args[0]
        dir = Dir.pwd
        @full_dir[0] = "#{dir}/#{@files[0]}"
        Message::Warning.no_toml(@files[0])
      end
    rescue NoArgument, FileNotExisting => e
      Message::Error.file_error(e.message)
      exit!
    end

    def file_exits?
      e = File.exist?(@args[0])
      d = File.directory?(@args[0])
      raise FileNotExisting unless e && !d
    end

    def no_file
      raise NoArgument if @args[0].nil?
    end

    class FileNotExisting < StandardError
      def message
        'Error: file not found or it is a directory'
      end
    end

    class NoArgument < TypeError
      def message
        'File no specified'
      end
    end
  end
end
