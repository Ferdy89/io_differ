module Carcant
  module Layer
    class FileSystem
      attr_reader :path

      def initialize(path: )
        @path = path
      end

      def create(data)
        with_file_and_contents do |file, contents|
          contents[current_timestamp] = data
          file.rewind
          file.write(JSON.dump(contents))
        end
      end

      def read_latest
        with_file_and_contents { |_, c| c[c.keys.max] }
      end

      private

      def with_file_and_contents
        File.open(path, 'r+') do |file|
          contents = JSON.load(file.read) || {}
          yield(file, contents)
        end
      end

      def current_timestamp
        Time.now.to_i.to_s
      end
    end
  end
end
