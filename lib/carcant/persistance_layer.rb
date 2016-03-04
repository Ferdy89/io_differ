require 'carcant/user'
require 'carcant/user_list'

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
      Carcant::UserList.new(
        store.read_latest.map do |row|
          Carcant::User.new(
            id:    row['id'],
            name:  row['name'],
          )
        end
      )
    end
  end
end
