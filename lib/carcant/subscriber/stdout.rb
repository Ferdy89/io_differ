module Carcant
  module Subscriber
    class Stdout
      COLORS = {
        red:   'e[31m',
        green: 'e[32m',
      }

      def self.hired(text)
        puts COLORS[:green] + text
      end

      def self.fired(text)
        puts COLORS[:red] + text
      end
    end
  end
end
