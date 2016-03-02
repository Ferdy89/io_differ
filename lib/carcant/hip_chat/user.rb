module Carcant
  class HipChat
    class User
      attr_reader :id, :mention_name, :name

      def initialize(id: , mention_name: , name: )
        @id           = id
        @mention_name = mention_name
        @name         = name
      end

      def to_h
        {
          'id'           => id,
          'mention_name' => mention_name,
          'name'         => name
        }
      end
    end
  end
end
