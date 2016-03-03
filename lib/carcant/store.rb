require 'carcant/hip_chat/user'
require 'carcant/hip_chat/user_list'

module Carcant
  class Store
    attr_reader :layer

    def initialize(layer: )
      @layer = layer
    end

    def write_user_list(list)
      layer.create(list.map(&:to_h))
    end

    def read_latest
      Carcant::HipChat::UserList.new(
        layer.read_latest.map do |row|
          Carcant::HipChat::User.new(
            id:            row['id'],
            name:          row['name'],
            mention_name:  row['mention_name']
          )
        end
      )
    end
  end
end
