require 'carcant/hip_chat/user'
require 'carcant/hip_chat/user_list'

module Carcant
  class PersistanceLayer
    attr_reader :store

    def initialize(store: )
      @store = store
    end

    def write_user_list(list)
      store.create(list.map(&:to_h))
    end

    def read_latest
      Carcant::HipChat::UserList.new(
        store.read_latest.map do |row|
          Carcant::HipChat::User.new(
            id:    row['id'],
            name:  row['name'],
          )
        end
      )
    end
  end
end
