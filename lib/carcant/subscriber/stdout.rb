module Carcant
  module Subscriber
    class Stdout
      COLORS = {
        red:   "\e[31m",
        green: "\e[32m",
        off:   "\e[0m",
      }

      def self.hired(text)
        puts COLORS[:green] + text + COLORS[:off]
      end

      def self.fired(text)
        puts COLORS[:red] + text + COLORS[:off]
      end
    end
  end
end
