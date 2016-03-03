module Carcant
  module Layer
    class FileSystem
      TIMESTAMP_KEY = 'timestamp'
      USERS_KEY     = 'users'

      attr_reader :path

      def initialize(path: )
        @path = path
      end

      def create(data)
        File.open(path, 'a') do |file|
          file.write(JSON.dump({
            USERS_KEY     => data,
            TIMESTAMP_KEY => current_timestamp
          }))
          file.write("\n")
        end
      end

      def read_latest
        last_from_file = File.readlines(path).last

        if last_from_file
          JSON.load(last_from_file)[USERS_KEY]
        else
          { }
        end
      end

      private

      def current_timestamp
        Time.now.to_i
      end
    end
  end
end
